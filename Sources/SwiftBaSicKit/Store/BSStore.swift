//
//  BSStore.swift
//
//
//  Created by Xiaowei Zhuang on 2023/10/27.
//

import Foundation
import StoreKit

@available(iOS 15, *)
public enum StoreError: Error {
    case failedVerification
    case requestProductFailed
}

@available(iOS 15, *)
public class BSStore: ObservableObject {
    
    typealias Transaction = StoreKit.Transaction
    typealias RenewalInfo = StoreKit.Product.SubscriptionInfo.RenewalInfo
    typealias RenewalState = StoreKit.Product.SubscriptionInfo.RenewalState
    
    /// 一次购买，用的多了，永久会员经常用
    @Published private(set) var nonconsumableProducts: [Product] = []
    /// 可消耗的，个人项目没有用过，以前公司项目倒是用过
    @Published private(set) var consumableProducts: [Product] = []
    /// 订阅啊，自动续费那种，有些项目用到了，基本大部分都会用上
    @Published private(set) var subscriptions: [Product] = []
    /// 不会自动续费的，没用过
    @Published private(set) var nonRenewables: [Product] = []
    
    /// 已购买的一次性购买
    @Published private(set) var purchasedNonconsumableProducts: [Product] = []
    /// 已购买的非自动续费产品
    @Published private(set) var purchasedNonRenewableSubscriptions: [Product] = []
    /// 已订阅的产品
    @Published private(set) var purchasedSubscriptions: [Product] = []
    /// 订阅组状态，目前还没有使用过多个组的情况
    @Published private(set) var subscriptionGroupStatus: RenewalState?
    
    var updateListenerTask: Task<Void, Error>? = nil

    private let productIds: [String]
    
    /// 按服务级别由高到低定义应用程序的订阅层级，按现有上架应用来看的话，用不到这个。
    public enum SubscriptionTier: Int, Comparable {
        case none = 0
        case standard = 1
        case premium = 2
        case pro = 3

        public static func < (lhs: Self, rhs: Self) -> Bool {
            return lhs.rawValue < rhs.rawValue
        }
    }
    
    init() {
        productIds = BSStore.loadProductIds()
    }
    
    init(productIds: [String]) {
        self.productIds = productIds
    }
    
    deinit {
        updateListenerTask?.cancel()
    }
    
    @MainActor
    func requestProducts() async throws {
        do {
            /// 使用 Products.plist 文件定义的标识符从 App Store 申请产品。
            let storeProducts = try await Product.products(for: productIds)

            var newNonconsumableProducts: [Product] = []
            var newSubscriptions: [Product] = []
            var newNonRenewables: [Product] = []
            var newConsumableProducts: [Product] = []

            /// 根据产品类别筛选产品。
            for product in storeProducts {
                switch product.type {
                case .consumable:
                    newConsumableProducts.append(product)
                case .nonConsumable:
                    newNonconsumableProducts.append(product)
                case .autoRenewable:
                    newSubscriptions.append(product)
                case .nonRenewable:
                    newNonRenewables.append(product)
                default:
                    /// 未知类型，忽略
                    print("Unknown product")
                }
            }

            /// 按价格从低到高对每个产品类别进行排序
            nonconsumableProducts = sortByPrice(newNonconsumableProducts)
            subscriptions = sortByPrice(newSubscriptions)
            nonRenewables = sortByPrice(newNonRenewables)
            consumableProducts = sortByPrice(newConsumableProducts)
        } catch {
            print("Failed product request from the App Store server: \(error)")
            throw StoreError.requestProductFailed
        }
    }
    
    func purchase(_ product: Product) async throws -> Transaction? {
        //Begin purchasing the `Product` the user selects.
        let result = try await product.purchase()

        switch result {
        case .success(let verification):
            /// 检查交易是否经过验证。如果没有该函数将重新抛出验证错误。
            let transaction = try checkVerified(verification)

            /// 交易验证成功，更新用户交易信息
            await updateCustomerProductStatus()

            /// 完成交易。
            await transaction.finish()

            return transaction
        case .userCancelled, .pending:
            return nil
        default:
            return nil
        }
    }
    
    func restore() async throws {
        try await AppStore.sync()
    }
    
    func listenForTransactions() -> Task<Void, Error> {
        return Task.detached {
            /// 遍历所有非直接调用 `purchase()` 的交易。
            for await result in Transaction.updates {
                do {
                    let transaction = try self.checkVerified(result)

                    /// 向用户交付产品。
                    await self.updateCustomerProductStatus()

                    /// 完成交易。
                    await transaction.finish()
                } catch {
                    /// 有交易未通过验证。
                    print("Transaction failed verification")
                }
            }
        }
    }
    
    func checkVerified<T>(_ result: VerificationResult<T>) throws -> T {
        /// 检查 JWS 是否通过 StoreKit 验证。
        switch result {
        case .unverified:
            /// StoreKit 对 JWS 进行了解析，但验证失败。
            throw StoreError.failedVerification
        case .verified(let safe):
            /// 结果已验证。返回解包值。
            return safe
        }
    }
    
    @MainActor
    func updateCustomerProductStatus() async {
        var purchasedNonconsumableProducts: [Product] = []
        var purchasedSubscriptions: [Product] = []
        var purchasedNonRenewableSubscriptions: [Product] = []

        /// 遍历用户购买的所有产品，个人产品里，这里应该不会有很多。
        for await result in Transaction.currentEntitlements {
            do {
                /// 检查交易是否已验证。如果未验证，则捕捉 `failedVerification` 错误。
                let transaction = try checkVerified(result)

                /// 检查交易的 `productType` 并从中获取相应的产品。
                switch transaction.productType {
                case .nonConsumable:
                    if let nonconsumableProduct = nonconsumableProducts.first(where: { $0.id == transaction.productID }) {
                        purchasedNonconsumableProducts.append(nonconsumableProduct)
                    }
                case .nonRenewable:
                    /*
                     非续订订阅没有固有的过期日期，因此它们总是包含在 `Transaction.currentEntitlements` 中。
                     这里将此非续订订阅的到期日定义为购买后一年。
                     如果当前日期距离 `purchaseDate` 不超过一年，则用户仍有权使用此产品。
                     这个其实还没有用过，暂时不处理。
                     */
                    if let nonRenewable = nonRenewables.first(where: { $0.id == transaction.productID }) {
                        
                        let currentDate = Date()
                        let expirationDate = Calendar(identifier: .gregorian).date(byAdding: DateComponents(year: 1),
                                                                   to: transaction.purchaseDate)!

                        if currentDate < expirationDate {
                            purchasedNonRenewableSubscriptions.append(nonRenewable)
                        }
                    }
                case .autoRenewable:
                    if let subscription = subscriptions.first(where: { $0.id == transaction.productID }) {
                        purchasedSubscriptions.append(subscription)
                    }
                default:
                    break
                }
            } catch {
                print()
            }
        }

        /// 用购买的产品更新信息。
        self.purchasedNonconsumableProducts = purchasedNonconsumableProducts
        self.purchasedNonRenewableSubscriptions = purchasedNonRenewableSubscriptions

        /// 更新可自动续订产品的信息。
        self.purchasedSubscriptions = purchasedSubscriptions

        /*
         检查 `subscriptionGroupStatus` 以了解自动续订状态，从而确定客户是新客户（从未订阅）还是不活跃客户（已过期订阅）。
         是新客户（从未订阅）、活跃客户还是非活跃客户（订阅过期）。
         这里默认只有一个订阅组因此订阅数组中的产品都属于同一个组。状态返回的状态适用于整个订阅组。
         多个组的情况如果以后有需要再更新处理。
         */
        subscriptionGroupStatus = try? await subscriptions.first?.subscription?.status.first?.state
    }
    
}

@available(iOS 15, *)
public extension BSStore {
    /// 检查是否已经购买指定产品。
    func isPurchased(_ product: Product) async throws -> Bool {
        switch product.type {
        case .nonRenewable:
            return purchasedNonRenewableSubscriptions.contains(product)
        case .nonConsumable:
            return purchasedNonconsumableProducts.contains(product)
        case .autoRenewable:
            return purchasedSubscriptions.contains(product)
        default:
            return false
        }
    }
}

@available(iOS 15, *)
extension BSStore {
//    <array>
//        <string>com.indie.lifetime</string>
//        <string>com.inide.monthly</string>
//        <string>com.indie.yearly</string>
//        <string>com.inide.lifetime.2</string>
//    </array>
    static func loadProductIds() -> [String] {
        guard let path = Bundle.main.path(forResource: "Products", ofType: "plist"),
              let plist = FileManager.default.contents(atPath: path),
              let data = try? PropertyListSerialization.propertyList(from: plist, format: nil) as? [String] else {
            fatalError("加载Products.plist出错, 请检查文件是否存在，或格式是否正确。")
        }
        return data
    }
    
    func sortByPrice(_ products: [Product]) -> [Product] {
        products.sorted(by: { return $0.price < $1.price })
    }
}

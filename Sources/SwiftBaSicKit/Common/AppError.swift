//
//  AppError.swift
//  SmallHabits
//
//  Created by Xiaowei Zhuang on 2023/7/20.
//

import Foundation

public enum AppError: Error {
    
    enum Premium {
        case none
        case premiumProductLoadError
        case premiumUnknow
        case premiumFrameworkError(string: String)
        case premiumCanNotPay
        case premiumAuthorizedError
        case premiumNoRecord
    }
}

extension AppError.Premium: Equatable { }

extension AppError.Premium {
    var desc: String {
        switch self {
            case .none: return ""
        case .premiumProductLoadError:
            return "Premium.Error.Product".localizable(nil, bundle: .module, "获取产品失败，请检查网络")
        case .premiumUnknow:
            return "Premium.Error.Unknow".localizable(nil, bundle: .module, "未知错误，请稍后再试。")
        case .premiumFrameworkError(let string):
            return string
        case .premiumCanNotPay:
            return "Premium.Error.CanNotPay".localizable(nil, bundle: .module, "暂不能支付，请稍后再试")
        case .premiumAuthorizedError:
            return "Premium.Error.Authorized".localizable(nil, bundle: .module, "未允许使用支付功能，请开启后再重试。")
        case .premiumNoRecord:
            return "Premium.Error.NoRecord".localizable(nil, bundle: .module, "没有找到购买记录")
        }
    }
}

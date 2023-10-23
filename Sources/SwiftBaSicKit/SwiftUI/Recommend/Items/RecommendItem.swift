//
//  RecommendItem.swift
//  Follow-up
//
//  Created by Xiaowei Zhuang on 2022/6/10.
//

import Foundation
import SwiftUI

protocol RecommendItem {
    var imageName: String { get }
    var title: LocalizedStringKey { get }
    var content: LocalizedStringKey { get }
    var scheme: URL { get }
    var url: URL { get }
    var bundleId: String { get }
    var isEnable: Bool { get }
    var backgroundColor: Color { get }
}

extension RecommendItem {
    var isInstalled: Bool { UIApplication.shared.canOpenURL(scheme) }
}

extension Color {
    static func rgb(r: Int, g: Int, b: Int) -> Color {
        return .init(red: Double(r) / 255.0, green: Double(g) / 255.0, blue: Double(b) / 255.0)
    }
}

public enum RecommendApp: Identifiable, CaseIterable {
    case tase, musiclist, habit, focus, xClock,moDev, moTip
    public var id: Self { self }
}

extension RecommendApp {
    var data: RecommendItem {
        switch self {
        case .tase: return TaSe()
        case .musiclist: return Musiclist()
        case .habit: return HiHabit()
        case .focus: return HiFocus()
        case .xClock: return XClock()
        case .moDev: return MoAppDev()
        case .moTip: return MoTip()
        }
    }
}


//let RecommendItems: [RecommendItem] = [



    // 颜采
//    RecommendItem(imageName: "Image_CC.png",
//                  title: Recommends.RecommendCCTitle,
//                  content: Recommends.RecommendCCContent,
//                  scheme: URL(string: "XiaoColorCollection://")!,
//                  url: URL(string: "https://apps.apple.com/us/app/%E9%A2%9C%E9%87%87/id1537356721")!,
//                  bundleId: "com.indie.ColorCollection",
//                  isEnable: true,
//                  backgroundColor: .rgb(r: 0, g: 152, b: 6)),
    // 晓记
//    RecommendItem(imageName: "Image_XDaily.png",
//                  title: Recommends.RecommendXDTitle,
//                  content: Recommends.RecommendXDContent,
//                  scheme: URL(string: "XDaily://")!,
//                  url: URL(string: "https://apps.apple.com/us/app/x-diary/id1610960136")!,
//                  bundleId: "com.indie.XiaoDaily",
//                  isEnable: true,
//                  backgroundColor: .rgb(r: 164, g:150, b: 128)),

    // 前情后续
//    RecommendItem(imageName: "Image_FU.png",
//                  title: Recommends.RecommendFUTitle,
//                  content: Recommends.RecommendFUContent,
//                  scheme: URL(string: "XiaoFollowup://")!,
//                  url: URL(string: "https://apps.apple.com/us/app/%E5%89%8D%E6%83%85%E5%90%8E%E7%BB%AD/id1626959505")!,
//                  bundleId: "com.indie.Follow-up",
//                  isEnable: true,
//                  backgroundColor: .rgb(r: 112, g: 182, b: 249)),
//].filter { $0.bundleId != (Bundle.main.bundleIdentifier ?? "") && $0.isEnable }

//
//  File.swift
//  
//
//  Created by Xiaowei Zhuang on 2023/10/23.
//

import Foundation
import SwiftUI

struct RateApp: FeedbackItem {
    var id: UUID = .init()
    
    var imageName: String = "star.bubble"
    
    var title: String = "Feedback.RateUs".localizable(bundle: .module, arguments: [BSApp.name()])
    
    func action() {
        if let appId = RecommendApp.allCases.filter({ $0.data.bundleId == (Bundle.main.bundleIdentifier ?? "") }).first?.data.appId {
            guard let writeReviewURL = URL(string: "https://apps.apple.com/app/\(appId)?action=write-review")
            else { fatalError("Expected a valid URL") }
            UIApplication.shared.open(writeReviewURL, options: [:], completionHandler: nil)
            return
        }
        fatalError("没有找到应用，快到SwiftBaSicKit项目里添加当前项目的AppID")
    }
    
    
}

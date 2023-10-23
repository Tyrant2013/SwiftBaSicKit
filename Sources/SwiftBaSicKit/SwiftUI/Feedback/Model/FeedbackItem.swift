//
//  File.swift
//  
//
//  Created by Xiaowei Zhuang on 2023/10/23.
//

import Foundation
import SwiftUI

protocol FeedbackItem: Identifiable {
    var id: UUID { get }
    var imageName: String { get }
    var title: String { get }
    
    func action() -> Void
}

enum FeedbackType: Identifiable, CaseIterable {
    var id: Self { self }
    
    case email, rate
}

extension FeedbackType {
    var data: any FeedbackItem {
        switch self {
        case .email: return Email()
        case .rate: return RateApp()
        }
    }
}

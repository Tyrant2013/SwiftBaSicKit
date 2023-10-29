//
//  File.swift
//  
//
//  Created by Xiaowei Zhuang on 2023/10/23.
//

import Foundation
import SwiftUI

protocol SupportItem: Identifiable {
    var id: UUID { get }
    var imageName: String { get }
    var title: String { get }
    
    func action() -> Void
}

enum SupportType: Identifiable, CaseIterable {
    var id: Self { self }
    
    case rate
}

extension SupportType {
    var data: any SupportItem {
        switch self {
        case .rate: return RateApp()
//        case .share: return ShareApp()
        }
    }
}

//
//  File.swift
//  
//
//  Created by Xiaowei Zhuang on 2023/10/23.
//

import Foundation
import SwiftUI

struct HiFocus: RecommendItem {
    let imageName: String = "Image_Focus"
    
    let title: LocalizedStringKey = .init("HiFocus")
    
    let content: LocalizedStringKey = .init("Recommend.App.Focus.Desc")
    
    let scheme: URL = URL(string: "HiFocus")!
    
    let url: URL = URL(string: "https://apps.apple.com/app/id6446201014")!
    
    let bundleId: String = "com.indie.OneThinkFocus"
    
    let appId: String = "id6446201014"
    
    let isEnable: Bool = true
    
    let backgroundColor: Color = .rgb(r: 225, g: 231, b: 238)
    
    
}

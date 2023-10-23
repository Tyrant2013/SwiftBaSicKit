//
//  File.swift
//  
//
//  Created by Xiaowei Zhuang on 2023/10/23.
//

import Foundation
import SwiftUI

struct HiFocus: RecommendItem {
    var imageName: String = "Image_Focus"
    
    var title: LocalizedStringKey = .init("HiFocus")
    
    var content: LocalizedStringKey = .init("Recommend.App.Focus.Desc")
    
    var scheme: URL = URL(string: "HiFocus")!
    
    var url: URL = URL(string: "https://apps.apple.com/app/id6446201014")!
    
    var bundleId: String = "com.indie.OneThinkFocus"
    
    var isEnable: Bool = true
    
    var backgroundColor: Color = .rgb(r: 225, g: 231, b: 238)
    
    
}

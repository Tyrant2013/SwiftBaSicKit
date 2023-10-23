//
//  File.swift
//  
//
//  Created by Xiaowei Zhuang on 2023/10/23.
//

import Foundation
import SwiftUI

struct MoTip: RecommendItem {
    let imageName: String = "Image_Tip"
    
    let title: LocalizedStringKey = .init("MoTip")
    
    let content: LocalizedStringKey = .init("Recommend.App.MoTip.Desc")
    
    let scheme: URL = URL(string: "XTip://")!
    
    let url: URL = URL(string: "https://apps.apple.com/app/id1624253137")!
    
    let bundleId: String = "com.indie.Tip"
    
    let appId: String = "id1624253137"
    
    let isEnable: Bool = true
    
    let backgroundColor: Color = .rgb(r: 51, g: 182, b: 229)
}

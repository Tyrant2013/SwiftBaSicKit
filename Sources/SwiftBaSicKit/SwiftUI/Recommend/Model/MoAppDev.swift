//
//  File.swift
//  
//
//  Created by Xiaowei Zhuang on 2023/10/23.
//

import Foundation
import SwiftUI

struct MoAppDev: RecommendItem {
    let imageName: String = "Image_MoDev"
    
    let title: LocalizedStringKey = .init("MoAppDev")
    
    let content: LocalizedStringKey = .init("Recommend.App.MoDev.Desc")
    
    let scheme: URL = URL(string: "MoAppDev://")!
    
    let url: URL = URL(string: "https://apps.apple.com/app/id1638682919")!
    
    let bundleId: String = "com.indie.MoAppConnectInfo"
    
    let appId: String = "id1638682919"
    
    let isEnable: Bool = true
    
    let backgroundColor: Color = .rgb(r: 225, g: 231, b: 238)
}

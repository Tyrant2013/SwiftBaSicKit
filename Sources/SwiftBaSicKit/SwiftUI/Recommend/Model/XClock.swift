//
//  File.swift
//  
//
//  Created by Xiaowei Zhuang on 2023/10/23.
//

import Foundation
import SwiftUI

struct XClock: RecommendItem {
    let imageName: String = "Image_XClock"
    
    let title: LocalizedStringKey = .init("Recommend.App.Clock")
    
    let content: LocalizedStringKey = .init("Recommend.App.Clock")
    
    let scheme: URL = URL(string: "XClock://")!
    
    let url: URL = URL(string: "https://apps.apple.com/app/id1596562904")!
    
    let bundleId: String = "com.indie.LittleClock"
    
    let appId: String = "id1596562904"
    
    let isEnable: Bool = true
    
    let backgroundColor: Color = .rgb(r: 229, g: 229, b: 220)
    
}

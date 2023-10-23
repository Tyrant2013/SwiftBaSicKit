//
//  File.swift
//  
//
//  Created by Xiaowei Zhuang on 2023/10/23.
//

import Foundation
import SwiftUI

struct TaSe: RecommendItem {
    let imageName: String = "Image_Tracker"
    
    let title: LocalizedStringKey = .init("TaSe")
    
    let content: LocalizedStringKey = .init("Recommend.App.TaSe.Desc")
    
    let scheme: URL = URL(string: "TaSe://")!
    
    let url: URL = URL(string: "https://apps.apple.com/app/id1641620172")!
    
    let bundleId: String = "com.indie.MDTracker"
    
    let appId: String = "id1641620172"
    
    let isEnable: Bool = true
    
    let backgroundColor: Color = .rgb(r: 246, g: 220, b: 140)
    
}

//
//  File.swift
//  
//
//  Created by Xiaowei Zhuang on 2023/10/23.
//

import Foundation
import SwiftUI

struct HiHabit: RecommendItem {
    let imageName: String = "Image_Habit"
    
    let title: LocalizedStringKey = .init("HiHabit")
    
    let content: LocalizedStringKey = .init("Recommend.App.TaSe.Desc")
    
    let scheme: URL = URL(string: "HiHabit")!
    
    let url: URL = URL(string: "https://apps.apple.com/app/id6451414190")!
    
    let bundleId: String = "com.indie.hihabit"
    
    let appId: String = "id6451414190"
    
    let isEnable: Bool = true
    
    let backgroundColor: Color = .rgb(r: 225, g: 231, b: 238)
    
    
}

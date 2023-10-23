//
//  File.swift
//  
//
//  Created by Xiaowei Zhuang on 2023/10/23.
//

import Foundation
import SwiftUI

struct HiHabit: RecommendItem {
    var imageName: String = "Image_Habit"
    
    var title: LocalizedStringKey = .init("HiHabit")
    
    var content: LocalizedStringKey = .init("Recommend.App.TaSe.Desc")
    
    var scheme: URL = URL(string: "HiHabit")!
    
    var url: URL = URL(string: "https://apps.apple.com/app/id6451414190")!
    
    var bundleId: String = "com.indie.hihabit"
    
    var isEnable: Bool = true
    
    var backgroundColor: Color = .rgb(r: 225, g: 231, b: 238)
    
    
}

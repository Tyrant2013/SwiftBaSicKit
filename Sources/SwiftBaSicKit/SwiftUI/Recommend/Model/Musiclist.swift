//
//  File.swift
//  
//
//  Created by Xiaowei Zhuang on 2023/10/23.
//

import Foundation
import SwiftUI

struct Musiclist: RecommendItem {
    let imageName: String = "Image_Music"
    
    let title: LocalizedStringKey = .init("Music-list")
    
    let content: LocalizedStringKey = .init("Recommend.App.Musiclist.Desc")
    
    let scheme: URL = URL(string: "Music-list")!
    
    let url: URL = URL(string: "https://apps.apple.com/app/id6469257865")!
    
    let bundleId: String = "com.indie.musiclist"
    
    let appId: String = "id6469257865"
    
    let isEnable: Bool = true
    
    let backgroundColor: Color = .rgb(r: 51, g: 182, b: 229)
    
    
}

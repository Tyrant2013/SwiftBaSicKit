//
//  File.swift
//  
//
//  Created by Xiaowei Zhuang on 2023/10/23.
//

import Foundation
import SwiftUI

struct Musiclist: RecommendItem {
    var imageName: String = "Image_Music"
    
    var title: LocalizedStringKey = .init("Music-list")
    
    var content: LocalizedStringKey = .init("Recommend.App.Musiclist.Desc")
    
    var scheme: URL = URL(string: "Music-list")!
    
    var url: URL = URL(string: "https://apps.apple.com/app/id6469257865")!
    
    var bundleId: String = "com.indie.musiclist"
    
    var isEnable: Bool = true
    
    var backgroundColor: Color = .rgb(r: 51, g: 182, b: 229)
    
    
}

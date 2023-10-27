//
//  XiaoHongshu.swift
//
//
//  Created by Xiaowei Zhuang on 2023/10/27.
//

import Foundation
import UIKit

struct XiaoHongshu: Contact {
    var id: UUID = UUID()
    
    var imageName: String = "xiaohongshu"
    
    var name: String = "小红书"
    
    func click() {
        guard let url = URL(string: "https://www.xiaohongshu.com/user/profile/63569010000000001901d33d") else { return }
        UIApplication.shared.open(url)
    }
    
    
}

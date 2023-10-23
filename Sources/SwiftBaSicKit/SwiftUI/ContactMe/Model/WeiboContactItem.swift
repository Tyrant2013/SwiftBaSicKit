//
//  WeiboContactItem.swift
//  SmallHabits
//
//  Created by Xiaowei Zhuang on 2023/10/9.
//

import Foundation
import UIKit

struct WeiboContactItem: Contact {
    var id: UUID = UUID()
    
    var imageName: String = "weibo"
    
    var name: String = "Weibo"
    
    func click() {
        UIApplication.shared.open(URL(string: "https://weibo.com/u/1862433935")!)
    }
    
    
}

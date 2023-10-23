//
//  TwitterContactItem.swift
//  SmallHabits
//
//  Created by Xiaowei Zhuang on 2023/10/9.
//

import Foundation
import UIKit

struct TwitterContactItem: Contact {
    var id: UUID = UUID()
    
    var imageName: String = "twitter"
    
    var name: String = "X"
    
    func click() {
        UIApplication.shared.open(URL(string: "https://twitter.com/Elliot_iOS")!)
    }
    
}

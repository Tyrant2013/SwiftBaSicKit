//
//  ContactItem.swift
//  SmallHabits
//
//  Created by Xiaowei Zhuang on 2023/10/9.
//

import Foundation

protocol ContactItem: Identifiable {
    var id: UUID { get }
    
    var imageName: String { get }
    var name: String { get }
}

protocol ContactItemAction {
    func click() -> Void
}

typealias Contact = ContactItem & ContactItemAction

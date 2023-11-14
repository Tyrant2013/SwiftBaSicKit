//
//  ContactItem.swift
//  SmallHabits
//
//  Created by Xiaowei Zhuang on 2023/10/9.
//

import Foundation

public protocol ContactItem: Identifiable {
    var id: UUID { get }
    
    var imageName: String { get }
    var name: String { get }
}

public protocol ContactItemAction {
    func click() -> Void
}

public typealias Contact = ContactItem & ContactItemAction

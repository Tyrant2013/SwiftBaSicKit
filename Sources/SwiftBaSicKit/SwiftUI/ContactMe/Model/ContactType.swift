//
//  ContactType.swift
//  SmallHabits
//
//  Created by Xiaowei Zhuang on 2023/10/9.
//

import Foundation

enum ContactType: Identifiable {
    
    static var allTypes: [ContactType] = [
        .appImage(item: TwitterContactItem()),
        .appImage(item: WeiboContactItem()),
        .systemImage(item: EmailContactItem())
    ]
    
    var id: UUID {
        switch self {
            case .appImage(let item): item.id
            case .systemImage(let item): item.id
        }
    }
    
    
    case appImage(item: any Contact)
    case systemImage(item: any Contact)
}

extension ContactType {
    var name: String {
        switch self {
            case .appImage(let item): return item.name
            case .systemImage(let item): return item.name
        }
    }
    
    func action() {
        switch self {
            case .appImage(let item): item.click()
            case .systemImage(let item): item.click()
        }
    }
}

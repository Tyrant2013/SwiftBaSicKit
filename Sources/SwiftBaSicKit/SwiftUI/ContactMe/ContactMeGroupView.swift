//
//  ContactMeGroupView.swift
//  SmallHabits
//
//  Created by Xiaowei Zhuang on 2023/10/9.
//

import SwiftUI

public struct ContactMeGroupView: View {
    public init() { }
    
    private let items: [ContactType] = ContactType.allTypes
    
    public var body: some View {
        ConfigSectionContainer {
            Text("Config.Contact.Me", bundle: .module, comment: "联系开发者")
                .font(.system(size: 16).bold())
                .foregroundColor(.primary)
                .frame(maxWidth: .infinity, alignment: .leading)
            AppDivider()
                .padding(.vertical, 8)
            ForEach(items) { ContactMeItem(type: $0) }
        }
    }
}

fileprivate struct ContactMeItem: View {
    let type: ContactType
    var body: some View {
        HStack {
            Group {
                switch type {
                    case .appImage(let item):
                        Image(item.imageName, bundle: .module)
                            .resizable()
                    case .systemImage(let item):
                        Image(systemName: item.imageName)
                            .resizable()
                }
            }
            .scaledToFit()
            .frame(width: 24, height: 24)
            .font(.system(size: 18))
            .clipShape(RoundedRectangle(cornerRadius: 6))
            .padding(.leading, 8)
            Text(type.name)
                .font(.system(size: 16).bold())
            Spacer()
            Image(systemName: "chevron.right")
                .font(.callout)
                .padding(.trailing)
        }
        .padding(.vertical, 12)
        .overlay(AppDivider(), alignment: .bottom)
        .makeClickable()
        .onTapGesture(perform: type.action)
    }
        
}

#Preview {
    ContactMeGroupView()
}

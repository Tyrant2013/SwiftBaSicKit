//
//  ContactMeGroupView.swift
//  SmallHabits
//
//  Created by Xiaowei Zhuang on 2023/10/9.
//

import SwiftUI

public struct ContactMeGroupView: View {
    public init() { }
    var showDivider = false
    private let items: [ContactType] = ContactType.allTypes
    
    public var body: some View {
        ConfigSectionContainer {
//            Text("Config.Contact.Me", bundle: .module, comment: "联系开发者")
//                .modifier(ConfigSectionTitleModifier())
//            AppDivider()
//                .padding(.top, 8)
            ForEach(items) {
                ContactMeItem(type: $0)
                    .padding(.leading, 8)
                    .padding(.vertical, 12)
                    .overlay(AppDivider().opacity(showDivider ? 1 : 0), alignment: .bottom)
            }
        }
    }
}

public struct ContactMeItem: View {
    let type: ContactType
    let imageSize: CGSize
    let titleFontSize: CGFloat
    let titleWeight: Font.Weight
    
    public init(type: ContactType,
         imageSize: CGSize = .init(width: 24, height: 24), 
         titleFontSize: CGFloat = 16,
         titleWeight: Font.Weight = .bold) {
        self.type = type
        self.imageSize = imageSize
        self.titleFontSize = titleFontSize
        self.titleWeight = titleWeight
    }
    public var body: some View {
        Button(action: type.action) {
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
                .frame(width: imageSize.width, height: imageSize.height)
                .clipShape(RoundedRectangle(cornerRadius: 6))
                Text(type.name)
                    .font(.system(size: titleFontSize).weight(titleWeight))
                Spacer()
                Image(systemName: "chevron.right")
                    .font(.callout)
                    .padding(.trailing)
            }
        }
    }
        
}

#Preview {
    ContactMeGroupView()
}

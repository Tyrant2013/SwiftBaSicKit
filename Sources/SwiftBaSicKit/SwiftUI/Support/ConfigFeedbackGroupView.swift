//
//  ConfigFeedbackGroupView.swift
//  
//
//  Created by Xiaowei Zhuang on 2023/10/23.
//

import SwiftUI

public struct SupportItemRow: View {
    let imageName: String
    let title: String
    var showDivider: Bool = true
    let action: () -> Void
    
    public init(imageName: String, title: String, showDivider: Bool = true, action: @escaping () -> Void) {
        self.imageName = imageName
        self.title = title
        self.showDivider = showDivider
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: imageName)
                Text(title)
                    .hAlign(.leading)
                Image(systemName: "chevron.right")
            }
            .font(.system(size: 18))
            .padding(.vertical, 8)
        }
        .overlay(AppDivider().opacity(showDivider ? 1 : 0), alignment: .bottom)
    }
}

public struct ConfigSupportGroupView<FeatureContent: View>: View {
    public init(@ViewBuilder featureContent: @escaping () -> FeatureContent) {
        self.featureContent = featureContent
    }
    
    @ViewBuilder
    let featureContent: () -> FeatureContent
    @State var startShare = false
    public var body: some View {
        ConfigSectionContainer {
//            Text("Support Us", bundle: .module, comment: "支持开发者")
//                .modifier(ConfigSectionTitleModifier())
//            AppDivider()
//                .padding(.top, 8)
            ForEach(SupportType.allCases) { item in
                let data = item.data
                SupportItemRow(imageName: data.imageName, title: data.title, action: data.action)
            }
            .padding(.horizontal, 8)
            
            featureContent()
                .padding(.horizontal, 8)
        }
    }
}

#Preview {
    VStack {
        if #available(iOS 15.0, *) {
            ConfigSupportGroupView(featureContent: {
                SupportItemRow(imageName: "square.and.arrow.up",
                               title: "Support.Share".localizable(bundle: .module,
                                                                  arguments: [BSApp.name()])) {
                    
                }
            })
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .foregroundColor(.black)
            .background(Color.white, in: RoundedRectangle(cornerRadius: 12))
            .environment(\.locale, .init(identifier: "zh"))
        }
    }
    .fullView()
    .background(Color.black)
}

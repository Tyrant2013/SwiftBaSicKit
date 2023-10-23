//
//  ConfigFeedbackGroupView.swift
//  
//
//  Created by Xiaowei Zhuang on 2023/10/23.
//

import SwiftUI

public struct ConfigFeedbackGroupView: View {
    public init() { }
    
    public var body: some View {
        ConfigSectionContainer {
            Text("Feedback")
                .modifier(ConfigSectionTitleModifier())
            AppDivider()
            ForEach(FeedbackType.allCases) { item in
                let data = item.data
                Button(action: data.action) {
                    HStack {
                        Image(systemName: data.imageName)
                        Text(data.title)
                            .hAlign(.leading)
                        Image(systemName: "chevron.right")
                    }
                    .font(.system(size: 18))
                    .padding(.vertical, 8)
                }
                AppDivider()
            }
            .padding(.horizontal, 8)
        }
    }
}

#Preview {
    VStack {
        if #available(iOS 15.0, *) {
            ConfigFeedbackGroupView()
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .foregroundColor(.black)
                .background(Color.white, in: RoundedRectangle(cornerRadius: 12))
        }
    }
    .fullView()
    .background(Color.black)
}

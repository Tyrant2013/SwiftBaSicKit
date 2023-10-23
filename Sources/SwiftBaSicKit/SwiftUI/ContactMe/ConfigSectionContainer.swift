//
//  ConfigSectionContainer.swift
//  SmallHabits
//
//  Created by Xiaowei Zhuang on 2023/10/10.
//

import SwiftUI

public struct ConfigSectionContainer<SectionContent: View>: View {
    public init(@ViewBuilder content: @escaping () -> SectionContent,
                itemSpace: CGFloat = 4,
                edge: Edge.Set = .all,
                padding: CGFloat = 8,
                cornerRadius: CGFloat = 12) {
        self.content = content
        self.itemSpace = itemSpace
        self.edge = edge
        self.padding = padding
        self.cornerRadius = cornerRadius
    }
    
    @ViewBuilder let content: () -> SectionContent
    let itemSpace: CGFloat
    let edge: Edge.Set
    let padding: CGFloat
    let cornerRadius: CGFloat
    public var body: some View {
        VStack(spacing: itemSpace) {
            content()
        }
        .foregroundColor(.primary)
        .padding(edge, padding)
        .background(
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(Color.white)
        )
    }
}

#Preview {
    ConfigSectionContainer {}
}

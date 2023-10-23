//
//  ConfigSectionTitleModifier.swift
//
//
//  Created by Xiaowei Zhuang on 2023/10/23.
//

import SwiftUI

struct ConfigSectionTitleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 16).bold())
            .hAlign(.leading)
    }
}

#Preview {
    Text("Title")
        .modifier(ConfigSectionTitleModifier())
}

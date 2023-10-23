//
//  AppDivider.swift
//  SmallHabits
//
//  Created by Xiaowei Zhuang on 2023/9/27.
//

import SwiftUI

public struct AppDivider: View {
    public var body: some View {
        Rectangle().frame(height: 1)
            .foregroundColor(.gray.opacity(0.1))
    }
}

#Preview {
    VStack {
        AppDivider()
    }
    .fullView()
    .background(Color.white)
}

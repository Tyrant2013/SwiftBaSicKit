//
//  SwiftUIView.swift
//  
//
//  Created by Xiaowei Zhuang on 2023/10/23.
//

import SwiftUI

struct SwiftUIView: View {
    var body: some View {
        VStack {
            ContactMeGroupView()
            RecommendGroupView()
        }
        .fullView()
        .background(Color.black)
    }
}

#Preview {
    SwiftUIView()
}

//
//  File.swift
//  
//
//  Created by Xiaowei Zhuang on 2024/1/3.
//

import SwiftUI

//https://www.youtube.com/watch?v=W-uSGXhuFHY&list=PL3GYQSkeNG7h7dE6vMwnqg2a6etUKTU2c&index=12&t=456s

struct AnimationEndCallback<Value: VectorArithmetic>: Animatable, ViewModifier {
    var animatableData: Value {
        didSet {
            checkIfAnimationFinished()
        }
    }
    
    var endValue: Value
    var onEnd: () -> ()
    
    init(endValue: Value, onEnd: @escaping () -> Void) {
        self.animatableData = endValue
        self.endValue = endValue
        self.onEnd = onEnd
    }
    
    func body(content: Content) -> some View {
        content
    }
    
    func checkIfAnimationFinished() {
        if animatableData == endValue {
            DispatchQueue.main.async {
                onEnd()
            }
        }
    }
}


struct AnimationEndCallbackExample: View {
    @State var progress: CGFloat = 0
    var body: some View {
        VStack {
            Button(action: { progress = 1 }) {
                Text("开始")
            }
        }
        .animation(.default, value: progress)
        .modifier(AnimationEndCallback(endValue: progress, onEnd: {
            print("animation finished")
        }))
    }
}

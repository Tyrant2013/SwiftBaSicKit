//
//  FeedbackButtonStyle.swift
//  OneThinkFocus
//
//  Created by Xiaowei Zhuang on 2023/4/1.
//

import SwiftUI

public struct FeedbackButtonStyle: ButtonStyle {
    var isFeedbackOn: Bool
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .opacity(configuration.isPressed ? 0.5 : 1)
            .onChange(of: configuration.isPressed) { newValue in
                guard isFeedbackOn && !newValue else { return }
                AppFeekback.selectionFeedback()
            }
    }
}

extension View {

    public func feedbackButtonStyle(isFeedbackOn: Bool = true) -> some View {
        self.buttonStyle(FeedbackButtonStyle(isFeedbackOn: isFeedbackOn))
    }
    
    public func onFeedbackTapGesture(count: Int = 1, isFeedbackOn: Bool = true, perform: @escaping () -> Void) -> some View {
        self.onTapGesture(count: count) {
            perform()
            guard isFeedbackOn else { return }
            AppFeekback.selectionFeedback()
        }
    }
}


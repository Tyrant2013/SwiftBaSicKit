//
//  View.swift
//  OneThinkFocus
//
//  Created by Xiaowei Zhuang on 2023/3/15.
//

import SwiftUI

extension View {
    public func hideKeyboard() {
        // For SwiftUI View
        let resign = #selector(UIResponder.resignFirstResponder)
        UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
        
        // For UIKit View
        let keyWindow = UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .map({$0 as? UIWindowScene})
                .compactMap({$0})
                .first?.windows
                .filter({$0.isKeyWindow}).first
        keyWindow?.rootViewController?.view.endEditing(true)
    }
    
    public func debugViewModify() {
        if #available(iOS 15, *) {
            Self._printChanges()
        }
    }
    
    public func makeClickable() -> some View {
        overlay(Color.white.opacity(0.01))
    }
}

extension View {
    public func fullView(_ alignment: Alignment = .center) -> some View {
        frame(maxWidth: .infinity, maxHeight: .infinity, alignment: alignment)
    }
    
    public func hAlign(_ align: Alignment) -> some View {
        frame(maxWidth: .infinity, alignment: align)
    }
    
    public func vAlign(_ align: Alignment) -> some View {
        frame(maxHeight: .infinity, alignment: align)
    }
}


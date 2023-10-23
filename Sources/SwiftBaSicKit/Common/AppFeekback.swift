//
//  AppFeekback.swift
//  OneThinkFocus
//
//  Created by Xiaowei Zhuang on 2023/3/13.
//

import Foundation
#if os(iOS)
import UIKit
import AudioToolbox

#endif

public class AppFeekback {
    public class func haptic() {
        #if os(iOS)
        let feedback = UIImpactFeedbackGenerator(style: .medium)
        feedback.prepare()
        feedback.impactOccurred()
        #endif
    }
    
    public class func selectionFeedback() {
        #if os(iOS)
        let feedback = UISelectionFeedbackGenerator()
        feedback.prepare()
        feedback.selectionChanged()
        #endif
    }
    
    public class func keyboardFeedback() {
        #if os(iOS)
        AudioServicesPlaySystemSound(SystemSoundID(1104))
        selectionFeedback()
        #endif
    }
    
    public class func pickerFeedback() {
        #if os(iOS)
        AudioServicesPlayAlertSound(kAudioServicesPropertyIsUISound)
        AudioServicesPlaySystemSound(1157)
        #endif
    }
}

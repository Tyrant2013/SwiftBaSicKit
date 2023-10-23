//
//  Device.swift
//  Music-list
//
//  Created by Xiaowei Zhuang on 2023/10/20.
//

import Foundation
import UIKit

public enum BSDevice {
    //MARK: 当前设备类型 iphone ipad mac
    public enum Devicetype {
        case iphone, ipad, mac
    }
    
    public static var deviceType: Devicetype{
#if os(macOS)
        return .mac
#else
        if  UIDevice.current.userInterfaceIdiom == .pad {
            return .ipad
        }
        else {
            return .iphone
        }
#endif
    }
}

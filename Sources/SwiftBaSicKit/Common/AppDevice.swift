//
//  App.swift
//  MDTracker
//
//  Created by Xiaowei Zhuang on 2022/8/29.
//

import Foundation
import UIKit
import AudioToolbox

public struct BSApp {
    public static func name() -> String {
        let name = NSLocalizedString("CFBundleDisplayName",
                                     tableName: "InfoPlist",
                                     bundle: Bundle.main,
                                     value: "",
                                     comment: "")
        return name
    }
    
    public static func version() -> String {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    }
    
    public static func systemInfoDescription() -> String {
        let iosVersion = UIDevice.current.systemVersion //ios版本
        let systemName = UIDevice.current.systemName //系统名称
        //        let modal = UIDevice.current.model //设备型号
        let localizedModel = UIDevice.current.localizedModel//设备区域化型号如A1533
        return "\(localizedModel), \(systemName) \(iosVersion)"
    }
}

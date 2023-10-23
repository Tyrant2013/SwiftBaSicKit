//
//  AppGroup.swift
//  MDTracker
//
//  Created by Xiaowei Zhuang on 2022/9/20.
//

import Foundation

//let appGroupName = "group.indie.musiclist"

public class BSAppGroup {
    public static let shared = BSAppGroup()
    var groupName: String = ""
    
    public func setupGroupName(_ groupName: String) { self.groupName = groupName }
    
    private func checkGroupNameAvailable() {
        if Self.shared.groupName.isEmpty {
            fatalError("Need to setup AppGroupName by using AppGroup.shared.setupGroupName(_:)")
        }
    }
    
    public var userDefaultsGroup: UserDefaults? {
        checkGroupNameAvailable()
        return UserDefaults(suiteName: Self.shared.groupName)
    }
    
    public var fileGroupURL: URL? {
        checkGroupNameAvailable()
        return FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: Self.shared.groupName)!
    }
}

//extension FileManager {
//    public static let group: URL? = {
//        if AppGroup.shared.groupName.isEmpty {
//            fatalError("Need to setup AppGroupName by using AppGroup.shared.setupGroupName(_:)")
//        }
//        return FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: AppGroup.shared.groupName)!
//    }()
//}
//
//extension UserDefaults {
//    public static let appGroup: UserDefaults? = {
//        if AppGroup.shared.groupName.isEmpty {
//            fatalError("Need to setup AppGroupName by using AppGroup.shared.setupGroupName(_:)")
//        }
//        return UserDefaults(suiteName: AppGroup.shared.groupName)
//    }()
//}

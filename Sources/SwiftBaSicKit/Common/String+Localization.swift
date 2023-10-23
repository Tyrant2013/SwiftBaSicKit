//
//  String+Localization.swift
//  Music-list
//
//  Created by Xiaowei Zhuang on 2023/10/18.
//

import Foundation

public enum LocalizableTableName: String {
    case mainBundle = ""
    case error = "Error"
}

extension String {
    public func localizable(_ tableName: String? = nil, bundle: Bundle = .main, _ comment: String = "") -> String {
        NSLocalizedString(self, tableName: tableName, bundle: bundle, comment: comment)
    }
    
    public func localizable(_ tableName: String? = nil,
                            bundle: Bundle = .main,
                            _ comment: String = "",
                            arguments: [CVarArg]) -> String {
        let format = localizable(tableName, bundle: bundle, comment)
        return String(format: format, arguments: arguments)
    }
    
    public static func tableName(_ tableName: LocalizableTableName) -> String {
        tableName.rawValue
    }
}

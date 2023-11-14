//
//  Calendar.swift
//
//
//  Created by Xiaowei Zhuang on 2023/11/14.
//

import Foundation

public extension Calendar {
    func daysWithinEra(_ from: Date, to: Date) -> Int {
        let startDay = ordinality(of: .day, in: .era, for: from)!
        let endDay = ordinality(of: .day, in: .era, for: to)!
        return endDay - startDay
    }
}

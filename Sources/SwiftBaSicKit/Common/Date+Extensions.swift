//
//  Date.swift
//  OneThinkFocus
//
//  Created by Xiaowei Zhuang on 2023/3/22.
//

import Foundation

extension Date {
    public static func last7Day() -> [Date] {
        let calendar = Calendar.current
        let start = calendar.startOfDay(for: calendar.date(byAdding: .day, value: -7, to: Date())!)
        var dates: [Date] = []
        for offset in 1...7 {
            dates.append(calendar.date(byAdding: .day, value: offset, to: start)!)
        }
        return dates
    }
    public static func thisWeek() -> [Date] {
        let calendar = Calendar.current
        let start = Date().startOfWeek
        var dates: [Date] = []
        for offset in 0..<7 {
            dates.append(calendar.date(byAdding: .day, value: offset, to: start)!)
        }
        return dates
    }
}

extension Date {
    public var calendar: Calendar { Calendar.current }
    public var firstDayofMonth: Date {
        var dateComponents = calendar.dateComponents([.year, .month, .day], from: self)
        dateComponents.day = 1
        return calendar.date(from: dateComponents)!
    }
    public var firstDayofYear: Date {
        var dateComponents = calendar.dateComponents([.year], from: self)
        dateComponents.day = 1
        dateComponents.month = 1
        return calendar.date(from: dateComponents)!
    }
    
    public var last7Day: [Date] {
        let start = calendar.startOfDay(for: calendar.date(byAdding: .day, value: -7, to: Date())!)
        var dates: [Date] = []
        for offset in 1...7 {
            dates.append(calendar.date(byAdding: .day, value: offset, to: start)!)
        }
        return dates
    }
    
    public var thisWeek: [Date] {
        let start = startOfWeek
        var dates: [Date] = []
        for offset in 0..<7 {
            dates.append(calendar.date(byAdding: .day, value: offset, to: start)!)
        }
        return dates
    }
    
    public var daysOfMonthWithOtherMonth: [Date] {
        let firstDay = self.firstDayofMonth
        let lastDay = self.lastDayofMonth
        let firstWeekday = calendar.component(.weekday, from: firstDay)
        let lastWeekday = calendar.component(.weekday, from: lastDay)
        
        let startDate = calendar.date(byAdding: .day, value: -(firstWeekday - 1), to: firstDay)!
        let lastDate = calendar.date(byAdding: .day, value: (7 - lastWeekday), to: lastDay)!
        
        let days = calendar.dateComponents([.day], from: startDate, to: lastDate).day!
        
        var ret: [Date] = []
        for index in (0...days) {
            let date = calendar.date(byAdding: .day, value: index, to: startDate)!
            ret.append(date)
        }
        return ret
    }

    public var monthsOfYear: [Date] {
        var dateComponents = calendar.dateComponents([.year], from: self)
        dateComponents.day = 1
        return (1...12).map({
            dateComponents.month = $0
            return calendar.date(from: dateComponents)!
        })
    }
}

extension Date {
    public var year: Int { calendar.component(.year, from: self) }
    public var month: Int { calendar.component(.month, from: self) }
    public var day: Int { calendar.component(.day, from: self) }
    public var hour: Int { calendar.component(.hour, from: self) }
    public var minute: Int { calendar.component(.minute, from: self) }
    
    public var monthName: String { calendar.monthSymbols[month - 1] }
    public var monthShortName: String { calendar.shortMonthSymbols[month - 1] }
    
    public var startOfWeek: Date {
        var weekday = Calendar.current.component(.weekday, from: Date())
        weekday = weekday == 1 ? 7 : (weekday - 1)
        return Calendar.current.date(byAdding: .day, value: 1 - weekday, to: Date())!
    }
    public var startOfMonth: Date {
        var dateComponents = calendar.dateComponents([.year, .month, .day], from: self)
        dateComponents.day = 1
        return calendar.date(from: dateComponents)!
    }
    public var lastDayofMonth: Date {
        let nextMonthDay = calendar.date(byAdding: .month, value: 1, to: firstDayofMonth)!
        return calendar.date(byAdding: .day, value: -1, to: nextMonthDay)!
    }
    public var previousMonth: Date {
        calendar.date(byAdding: .month, value: -1, to: startOfMonth)!
    }
    public var nextMonth: Date {
        calendar.date(byAdding: .month, value: 1, to: startOfMonth)!
    }
    
    public var dateTitle: String {
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "MMMd",
                                                        options: 0,
                                                        locale: .current) ?? "MMMd"
        return formatter.string(from: self)
    }
    /// 指定时间的开始: 0点
    public var start: Date {
        calendar.startOfDay(for: self)
    }
    /// 指定时间的第二天
    public var tomorrow: Date {
        calendar.date(byAdding: .day, value: 1, to: start)!
    }
}

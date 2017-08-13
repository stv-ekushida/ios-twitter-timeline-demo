//
//  Date+Calendar.swift
//  ios-extension-demo
//
//  Created by Eiji Kushida on 2017/03/14.
//  Copyright © 2017年 Eiji Kushida. All rights reserved.
//

import Foundation

public extension Date {
    
    /// 月初めの日付を取得する
    func startOfMonth() -> Date? {
        var comp: DateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour],
                                                                   from: Calendar.current.startOfDay(for: self))
        comp.day = 1
        comp.hour = 9
        return Calendar.current.date(from: comp)!
    }
    
    /// 月終わりの日付を取得する
    func endOfMonth() -> Date? {
        var comp: DateComponents = Calendar.current.dateComponents([.month, .month, .day, .hour],
                                                                   from: Calendar.current.startOfDay(for: self))
        comp.month = 1
        comp.day = -1
        comp.hour = 9
        return Calendar.current.date(byAdding: comp, to: self.startOfMonth()!)
    }
    
    /// 先月の日付を取得する
    func preMonth() -> Date {
        
        var comp = DateComponents()
        comp.month = -1
        comp.hour = 9
        return NSCalendar.current.date(byAdding: comp,to: self)!
    }
    
    /// 翌月の日付を取得する
    func nextMonth() -> Date {
        
        var comp = DateComponents()
        comp.month = 1
        comp.hour = 9
        return NSCalendar.current.date(byAdding: comp,to: self)!
    }
    
    /// 日付から曜日を取得する(Short Ver.)
    func shortWeekdayStr() -> String {
        return weekDaySymbol(date: self, style: .short)
    }
    
    /// 日付から曜日を取得する
    func weekdayStr() -> String {
        return weekDaySymbol(date: self, style: .normal)
    }
    
    private enum WeekDayStyle {
        case normal
        case short
    }
    
    private func weekDaySymbol(date: Date, style: WeekDayStyle) -> String {
        let calendar = Calendar.init(identifier: .gregorian)
        let weekday = calendar.component(.weekday, from: date)
        
        let weekdaySymbolIndex = weekday - 1
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ja")
        
        switch style {
        case .normal:
            return formatter.weekdaySymbols[weekdaySymbolIndex]
        case .short:
            return formatter.shortWeekdaySymbols[weekdaySymbolIndex]
        }
    }}

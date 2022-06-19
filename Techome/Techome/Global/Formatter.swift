//
//  Formatter.swift
//  Techome
//
//  Created by Yeongwoo Kim on 2022/06/10.
//

import Foundation

struct Formatter {
    static var dateWithTime: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        return dateFormatter
    }

    static var date: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }
    
    static var dateSimpleFormat: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M/d"
        return dateFormatter
    }
    
    static var remainingTime: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "a h시 mm분"
        dateFormatter.locale = Locale(identifier: "ko")
        return dateFormatter
    }
    
    static var koreanYearMonthDay: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "Y년 M월 d일"
        return dateFormatter
    }
    
    static var koreanMonthDay: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M월 d일"
        return dateFormatter
    }
}

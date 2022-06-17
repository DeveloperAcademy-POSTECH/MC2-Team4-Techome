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
    
    static var remainingTime: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "a H시 mm분"
        dateFormatter.locale = Locale(identifier: "ko")
        return dateFormatter
    }
}

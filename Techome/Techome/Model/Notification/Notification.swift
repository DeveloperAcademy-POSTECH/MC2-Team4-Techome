//
//  Notification.swift
//  Techome
//
//  Created by Seungyun Kim on 2022/06/16.
//

import Foundation
import UserNotifications

enum NotificationText: String, CaseIterable, Hashable, Codable {
    case recordNotification = "record"
    case warningNotification = "warning"
    case trendNotification = "trend"
    
    func getNotificationSubtitle() -> String {
        switch self {
        case .recordNotification:
            return "오늘의 카페인을 기록하셨나요?"
        case .warningNotification:
            return "너무 많은 카페인을 섭취하지 않으셨나요?"
        case .trendNotification:
            return "취침 5시간 전입니다."
        }
    }
    
    func getNotificationBody() -> String {
        switch self {
        case .recordNotification:
            return "체내 카페인 배출을 위해 물 한잔 어떠신가요? 💧"
        case .warningNotification:
            return "체내 많은 카페인 함유는 부가적인 증상을 나타낼 수 있습니다. 🤕"
        case .trendNotification:
            return "원활한 수면을 위해 카페인 섭취를 자제해주세요. 🛏"
        }
    }
    
    func getNotificationType(date: DateComponents) -> UNNotificationTrigger {
        switch self {
        case .recordNotification:
            return UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
        case .warningNotification:
            return UNTimeIntervalNotificationTrigger(timeInterval: 1800, repeats: false)
        case .trendNotification:
            return UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
        }
    }
    
    func getNotificationTime() -> DateComponents {
        var date = DateComponents()
        switch self {
        case .recordNotification:
            date.hour = 21
            date.minute = 00
            return date
        case .warningNotification:
            date.hour = 00
            date.minute = 00
            return date
        case .trendNotification:
            date.hour = 18
            date.minute = 00
            return date
        }
    }
}

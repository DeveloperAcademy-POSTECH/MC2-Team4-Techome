//
//  NotificationManager.swift
//  Techome
//
//  Created by Seungyun Kim on 2022/06/15.
//

import Foundation
import UserNotifications
import SwiftUI

struct Notification {
    var id : String
    var title : String
    var textType: NotificationText
}

final class NotificationManager {
    
    var notifications = [Notification]()
    
    func requestPermission() {
        UNUserNotificationCenter
            .current()
            .requestAuthorization(options: [.alert , .badge , .alert]) { granted, error in
                if granted == true && error == nil {
                    print("granted")
                } else {
                    print("not granted")
                }
            }
    }
    
    func addNotification(title: String, textType: NotificationText) -> Void {
        notifications.append(Notification(id: UUID().uuidString, title: title, textType: textType))
    }
    
    func schedule(textType: NotificationText) -> Void {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .notDetermined :
                self.requestPermission()
            case .authorized, .provisional :
                self.scheduleNotifications(isOn: true, textType: textType)
            default :
                break
            }
        }
    }
    
    func scheduleNotifications(isOn: Bool, textType: NotificationText) -> Void {
        
        for notification in notifications {
            let content = UNMutableNotificationContent()
            content.title = notification.title
            
            content.sound = UNNotificationSound.defaultCritical
            content.subtitle = notification.textType.getNotificationSubtitle()
            content.body = notification.textType.getNotificationBody()
            content.badge = 0
            
            let trigger = notification.textType.getNotificationType(date: notification.textType.getNotificationTime())
            let request = UNNotificationRequest(identifier: notification.id, content: content, trigger: trigger)
            
            if isOn {
                UNUserNotificationCenter.current().add(request) { error in
                    guard error == nil else { return}
                }
            } else {
                UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [request.identifier])
            }
        }
    }
}

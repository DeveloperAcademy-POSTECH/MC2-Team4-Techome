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
        print("permission")
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
        print("add")
        notifications.append(Notification(id: UUID().uuidString, title: title, textType: textType))
    }

    
    func schedule() -> Void {
        print("schedule!!")
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .notDetermined :
                self.requestPermission()
            case .authorized, .provisional :
                self.scheduleNotifications(isOn: true)
         
            default :
                break
            }
        }
    }
    
    func scheduleNotifications(isOn: Bool) -> Void {
       
        for notification in notifications {
            let content = UNMutableNotificationContent()
            content.title = notification.title
            
            content.sound = UNNotificationSound.defaultCritical
            content.subtitle = notification.textType.getNotificationSubtitle()
            content.body = notification.textType.getNotificationBody()
            content.badge = 0

            
            var date = DateComponents()
            date.hour = 18
            date.minute = 00
//            let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
            
//         Test용 3초뒤 알람
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
            let request = UNNotificationRequest(identifier: notification.id, content: content, trigger: trigger)
            
            if isOn {
                UNUserNotificationCenter.current().add(request) { error in
                    guard error == nil else { return}
                    print("Scheduling notification with id : \(notification.id)")
                }
            } else {
                print("removeall!!")
                UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                
            }
            
            
        }
    }
}

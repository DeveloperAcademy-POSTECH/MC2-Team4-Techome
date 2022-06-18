//
//  NotificationStateHolder.swift
//  Techome
//
//  Created by Seungyun Kim on 2022/06/15.
//

import Foundation

final class NotificationStateHolder: ObservableObject {
    @Published var isRecordNotificationOn: Bool = UserDefaults.standard.bool(forKey: "isRecordNotificationOn")
    @Published var isTrendNotificationOn: Bool = UserDefaults.standard.bool(forKey: "isTrendNotificationOn")
    
    func setNotification(textType: NotificationText) -> Void {
        let manager = NotificationManager()
        manager.requestPermission()
        manager.addNotification(title: "택이네 🏡", textType: textType)
        manager.schedule(textType: textType)
    }

    func delNotification(textType: NotificationText) -> Void {
        let manager = NotificationManager()
        manager.addNotification(title: "택이네 🏡", textType: textType)
        manager.scheduleNotifications(isOn: false, textType: textType)
        
    }
}

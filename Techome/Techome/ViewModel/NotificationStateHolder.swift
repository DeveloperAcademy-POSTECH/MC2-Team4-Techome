//
//  NotificationStateHolder.swift
//  Techome
//
//  Created by Seungyun Kim on 2022/06/15.
//

import Foundation

final class NotificationStateHolder: ObservableObject {
    @Published var isAllNotificationOn: Bool = false
    @Published var isRecordNotificationOn: Bool = false
    @Published var isWarningNotificationOn: Bool = false
    @Published var isTrendNotificationOn: Bool = false
    @Published var showAlert: Bool = false
    
    func setNotification(textType: NotificationText) -> Void {
        let manager = NotificationManager()
        manager.requestPermission()
        manager.addNotification(title: "택이네 🏡", textType: textType)
        manager.schedule()
    }

    func delNotification(textType: NotificationText) -> Void {
        let manager = NotificationManager()
        manager.addNotification(title: "택이네 🏡", textType: textType)
        manager.scheduleNotifications(isOn: false)
        
    }
}

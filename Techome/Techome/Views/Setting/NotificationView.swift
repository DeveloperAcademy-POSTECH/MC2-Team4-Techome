//
//  NotificationView.swift
//  Techome
//
//  Created by Seungyun Kim on 2022/06/15.
//

import SwiftUI

struct NotificationView: View {
    
    @EnvironmentObject var notificationStateHolder: NotificationStateHolder
    
    var body: some View {
        VStack {
            HStack{
                Text("기록 알림")
                Spacer()
                Toggle("notification", isOn: $notificationStateHolder.isRecordNotificationOn)
                    .labelsHidden()
                    .frame(height: 20)
                    .onChange(of: notificationStateHolder.isRecordNotificationOn) { value in
                        if value {
                            notificationStateHolder.setNotification(textType: NotificationText.recordNotification)
                        }else {
                            notificationStateHolder.delNotification(textType: NotificationText.recordNotification)
                        }
                    }
                    .padding(12)
                    .padding(.horizontal, 10)
                
            }
            
            HStack{
                Text("경고 알림")
                Spacer()
                Toggle("notification", isOn: $notificationStateHolder.isWarningNotificationOn)
                    .labelsHidden()
                    .frame(height: 20)
                    .onChange(of: notificationStateHolder.isWarningNotificationOn) { value in
                        if value {
                            notificationStateHolder.setNotification(textType: NotificationText.warningNotification)
                        }else {
                            notificationStateHolder.delNotification(textType: NotificationText.warningNotification)
                        }
                    }
                    .padding(12)
                    .padding(.horizontal, 10)
            }
            
            HStack{
                Text("추이 알림")
                Spacer()
                Toggle("notification", isOn: $notificationStateHolder.isTrendNotificationOn)
                    .labelsHidden()
                    .frame(height: 20)
                    .onChange(of: notificationStateHolder.isTrendNotificationOn) { value in
                        if value {
                            notificationStateHolder.setNotification(textType: NotificationText.trendNotification)
                        }else {
                            notificationStateHolder.delNotification(textType: NotificationText.trendNotification)
                        }
                    }
                    .padding(12)
                    .padding(.horizontal, 10)
            }
        }
    }
}


struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NotificationView()
        }
    }
}

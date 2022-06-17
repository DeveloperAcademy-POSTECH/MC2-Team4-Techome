//
//  SettingView.swift
//  Techome
//
//  Created by Seungyun Kim on 2022/06/15.
//

import SwiftUI

struct SettingView: View {
    var notificationStateHolder = NotificationStateHolder()
    
    var body: some View {
        NotificationView()
            .environmentObject(notificationStateHolder)
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}

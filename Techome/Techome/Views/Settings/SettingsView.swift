//
//  SettingsView.swift
//  Techome
//
//  Created by 김유나 on 2022/06/15.
//

import SwiftUI
import UIKit
import MessageUI

struct SettingsLayoutValue {
    
    struct Padding {
        static let overallHorizontal: CGFloat = 15
        static let groupTop: CGFloat = 8
        static let dividerTop: CGFloat = 8
        static let labelLeadingExtra: CGFloat = 3
        static let labelTop: CGFloat = 35
        static let toggleRowHorizontal: CGFloat = 17
        static let toggleRowVertical: CGFloat = 11
        static let infoRowHorizontal: CGFloat = 17
        static let infoRowVertical: CGFloat = 16
    }
    
    struct Radius {
        static let list : CGFloat = 7
        static let listShadow : CGFloat = 4
    }
    
}

struct SettingsView: View {
    
    @Environment(\.presentationMode) var presentation: Binding<PresentationMode>
    
    @State private var showMailSheet = false
    @State var result: Result<MFMailComposeResult, Error>? = nil
    
    var body: some View {
        
        NavigationView {
            ZStack(alignment: .leading) {
                Color.backgroundCream.edgesIgnoringSafeArea(.all)
                
                VStack(alignment: .leading, spacing: .zero) {
                    NoticeGroup()
                    InfoGroup(showMailSheet: $showMailSheet)
                    Spacer()
                }
                .padding(.horizontal, SettingsLayoutValue.Padding.overallHorizontal)
                .foregroundColor(.customBlack)
            }
            .navigationTitle("설정")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading: Button(action: {
                    self.presentation.wrappedValue.dismiss()
                }) {
                    Text("취소")
                        .foregroundColor(.primaryBrown)
                }
            )
            .sheet(isPresented: $showMailSheet) {
                SettingsMailView(result: self.$result, title: "[잔잔이]", body: "[제안 내용]")
            }
        }
        
    }
}

struct NoticeGroup: View {
    
    @ObservedObject var notificationStateHolder = NotificationStateHolder()
    
    var body: some View {
        
        GroupLabel(labelText: "알림")
        
        VStack(spacing: .zero) {
            NoticeRow(toggleText: "기록 알림", isOnState: $notificationStateHolder.isRecordNotificationOn)
                .onChange(of: notificationStateHolder.isRecordNotificationOn) { value in
                    UserDefaults.standard.set(value, forKey: "isRecordNotificationOn")
                    if value {
                        notificationStateHolder.setNotification(textType: NotificationText.recordNotification)
                    }else {
                        notificationStateHolder.delNotification(textType: NotificationText.recordNotification)
                    }
                }
            Divider()
                .foregroundColor(.primaryShadowGray)
                .padding(.horizontal, SettingsLayoutValue.Padding.dividerTop)
            NoticeRow(toggleText: "추이 알림", isOnState: $notificationStateHolder.isTrendNotificationOn)
//                .labelsHidden()
                .onChange(of: notificationStateHolder.isTrendNotificationOn) { value in
                    UserDefaults.standard.set(value, forKey: "isTrendNotificationOn")
                    if value {
                        notificationStateHolder.setNotification(textType: NotificationText.trendNotification)
                    }else {
                        notificationStateHolder.delNotification(textType: NotificationText.trendNotification)
                    }
                }
        }
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: SettingsLayoutValue.Radius.list))
        .padding(.top, SettingsLayoutValue.Padding.groupTop)
        .shadow(color: Color.primaryShadowGray, radius: SettingsLayoutValue.Radius.listShadow, x: .zero, y: .zero)
        .tint(.primaryBrown)
    }
}

struct InfoGroup: View {
    
    @Binding var showMailSheet: Bool
    @State private var showAlert: Bool = false
    
    var body: some View {
        
        GroupLabel(labelText: "정보")
        
        VStack(spacing: .zero) {
            NavigationLink(destination: {
                SettingsTeamView()
                    .navigationBarHidden(true)
            }){
                InfoRow(informationText: "팀 소개")
            }
            
            Divider()
                .foregroundColor(.primaryShadowGray)
                .padding(.horizontal, SettingsLayoutValue.Padding.dividerTop)
            
            NavigationLink(destination: {
                SettingsOpenSourceView()
                    .navigationBarHidden(true)
            }){
                InfoRow(informationText: "오픈소스 라이선스")
            }
            
            Divider()
                .foregroundColor(.primaryShadowGray)
                .padding(.horizontal, SettingsLayoutValue.Padding.dividerTop)
            
            NavigationLink(destination: {
                SettingsPolicyView()
                    .navigationBarHidden(true)
            }){
                InfoRow(informationText: "개인정보 처리방침")
            }
            
            Divider()
                .foregroundColor(.primaryShadowGray)
                .padding(.horizontal, SettingsLayoutValue.Padding.dividerTop)
            
            InfoRow(informationText: "개발자에게 의견 남기기")
                .onTapGesture {
                    mailConnectionFeature()
                }
        }
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: SettingsLayoutValue.Radius.list))
        .padding(.top, SettingsLayoutValue.Padding.groupTop)
        .shadow(color: Color.primaryShadowGray, radius: SettingsLayoutValue.Radius.listShadow, x: .zero, y: .zero)
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Error"), message: Text("메일을 보낼 수 없습니다."))
        }
    }
    
    private func mailConnectionFeature() {
        if MFMailComposeViewController.canSendMail() {
            showMailSheet = true
        } else {
            showAlert = true
        }
    }
}

struct GroupLabel: View {
    
    let labelText: String
    
    var body: some View {
        Text(labelText)
            .padding(.leading, SettingsLayoutValue.Padding.labelLeadingExtra)
            .padding(.top, SettingsLayoutValue.Padding.labelTop)
            .font(.title3)
    }
}

struct NoticeRow: View {
    
    let toggleText: String
    @Binding var isOnState: Bool
    
    var body: some View {
        Toggle(toggleText, isOn: $isOnState)
            .padding(.horizontal, SettingsLayoutValue.Padding.toggleRowHorizontal)
            .padding(.vertical, SettingsLayoutValue.Padding.toggleRowVertical)
    }
}

struct InfoRow: View {
    
    let informationText: String
    
    var body: some View {
        HStack {
            Text(informationText)
                .font(.body)
            Spacer()
            Image(systemName: "chevron.right")
        }
        .padding(.horizontal, SettingsLayoutValue.Padding.infoRowHorizontal)
        .padding(.vertical, SettingsLayoutValue.Padding.infoRowVertical)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

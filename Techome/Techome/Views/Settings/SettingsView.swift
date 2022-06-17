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

    }
    
    struct Size {
        
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
                    InformationGroup(showMailSheet: $showMailSheet)
                    Spacer()
                }
                .padding(.horizontal, 15)
                .foregroundColor(.customBlack)
            }
            .navigationTitle("설정")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading: Button(action: {
                    self.presentation.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .font(.headline)
                        .foregroundColor(.primaryBrown)
                }
            )
            .sheet(isPresented: $showMailSheet) {
                SettingsMailView(result: self.$result, title: "[앱이름]", body: "[제안 내용]")
            }
        }
        
    }
}

struct NoticeGroup: View {
    
    @State private var recordNotice: Bool = true
    @State private var trendNotice: Bool = true
    
    var body: some View {
        
        GroupLabel(labelText: "알림")
        
        VStack(spacing: .zero) {
            NoticeRow(toggleText: "기록 알림", isOnState: $recordNotice)
            Divider()
                .foregroundColor(.primaryShadowGray)
                .padding(.horizontal, 8)
            NoticeRow(toggleText: "추이 알림", isOnState: $trendNotice)
        }
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: SettingsLayoutValue.Radius.list))
        .padding(.top, 8)
        .shadow(color: Color.primaryShadowGray, radius: SettingsLayoutValue.Radius.listShadow, x: .zero, y: .zero)
        .tint(.primaryBrown)
    }
}

struct InformationGroup: View {
    
    @Binding var showMailSheet: Bool
    @State private var showAlert: Bool = false
    
    var body: some View {
        
        GroupLabel(labelText: "정보")
        VStack(spacing: .zero) {
            NavigationLink(destination: {
                SettingsTeamView()
                    .navigationBarHidden(true)
            }){
                InformationRow(informationText: "팀 소개")
            }
            
            Divider()
                .foregroundColor(.primaryShadowGray)
                .padding(.horizontal, 8)
            
            NavigationLink(destination: {
                SettingsOpenSourceView()
                    .navigationBarHidden(true)
            }){
                InformationRow(informationText: "오픈소스 라이선스")
            }
            
            Divider()
                .foregroundColor(.primaryShadowGray)
                .padding(.horizontal, 8)
            
            NavigationLink(destination: {
                SettingsPolicyView()
                    .navigationBarHidden(true)
            }){
                InformationRow(informationText: "개인정보 처리방침")
            }
            
            Divider()
                .foregroundColor(.primaryShadowGray)
                .padding(.horizontal, 8)
            
            InformationRow(informationText: "개발자에게 의견 남기기")
                .onTapGesture {
                    mailConnectionFeature()
                }
        }
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: SettingsLayoutValue.Radius.list))
        .padding(.top, 8)
        .shadow(color: Color.primaryShadowGray, radius: SettingsLayoutValue.Radius.listShadow, x: .zero, y: .zero)
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Error"), message: Text("메일을 보낼 수 없습니다."))
        }
    }
    
    func mailConnectionFeature() {
        if MFMailComposeViewController.canSendMail() {
            showMailSheet = true
        } else {
            showAlert = true
        }
    }
}

struct GroupLabel: View {
    
    var labelText: String
    
    var body: some View {
        Text(labelText)
            .padding(.leading, 3)
            .padding(.top, 35)
            .font(.title3)
    }
}

struct NoticeRow: View {
    
    var toggleText: String
    @Binding var isOnState: Bool
    
    var body: some View {
        Toggle(toggleText, isOn: $isOnState)
            .padding(.horizontal, 17)
            .padding(.vertical, 11)
    }
}

struct InformationRow: View {
    
    var informationText: String
    
    var body: some View {
        HStack {
            Text(informationText)
                .font(.body)
            Spacer()
            Image(systemName: "chevron.right")
        }
        .padding(.horizontal, 17)
        .padding(.vertical, 16)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

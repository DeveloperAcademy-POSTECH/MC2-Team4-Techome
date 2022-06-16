//
//  SettingsView.swift
//  Techome
//
//  Created by 김유나 on 2022/06/15.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        
        NavigationView {
            ZStack(alignment: .leading) {
                Color.backgroundCream.edgesIgnoringSafeArea(.all)
                
                VStack(alignment: .leading, spacing: .zero) {
                    NoticeGroup()
                    InformationGroup()
                    Spacer()
                }
            }
            .navigationTitle("설정")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading: Button(action: {
                    self.mode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "multiply")
                        .font(.headline)
                        .foregroundColor(.primaryBrown)
                }
            )
        }
        
    }
}

struct NoticeGroup: View {
    
    @State private var recordNotice: Bool = true
    @State private var warningNotice: Bool = true
    @State private var trendNotice: Bool = true
    
    var body: some View {
        
        GroupLabel(labelText: "알림")
        
        VStack(spacing: .zero) {
            NoticeRow(toggleText: "기록 알림", isOnState: $recordNotice)
            DividerCustom()
            NoticeRow(toggleText: "경고 알림", isOnState: $warningNotice)
            DividerCustom()
            NoticeRow(toggleText: "추이 알림", isOnState: $trendNotice)
        }
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 7))
        .padding(.horizontal, 15)
        .padding(.top, 8)
        .shadow(color: Color.primaryShadowGray, radius: 4, x: .zero, y: .zero)
        .font(.body)
        .foregroundColor(.customBlack)
        .tint(.primaryBrown)
    }
}

struct InformationGroup: View {
    var body: some View {
        
        GroupLabel(labelText: "정보")
        
        VStack(spacing: .zero) {
            
            NavigationLink(destination: {
                SettingsCompanyView()
                    .navigationBarHidden(true)
            }){
                InformationRowContent(informationText: "팀 소개")
            }
            DividerCustom()
            
            NavigationLink(destination: {
                SettingsOpenSourceView()
                    .navigationBarHidden(true)
            }){
                InformationRowContent(informationText: "오픈소스 라이브러리")
            }
            DividerCustom()
            
            NavigationLink(destination: {
                SettingsPersonalInformationView()
                    .navigationBarHidden(true)
            }){
                InformationRowContent(informationText: "개인정보 및 보안 도움말")
            }
            DividerCustom()
            
            NavigationLink(destination: {
                SettingsAddOpinionView()
                    .navigationBarHidden(true)
            }){
                InformationRowContent(informationText: "개발자에게 의견 남기기")
            }
        }
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 7))
        .padding(.horizontal, 15)
        .padding(.top, 8)
        .shadow(color: Color.primaryShadowGray, radius: 4, x: .zero, y: .zero)
        .font(.body)
        .foregroundColor(.customBlack)
    }
}

struct GroupLabel: View {
    
    var labelText: String
    
    var body: some View {
        Text(labelText)
            .padding(.leading, 18)
            .padding(.top, 38)
            .font(.title3)
            .foregroundColor(.customBlack)
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

struct InformationRowContent: View {
    
    var informationText: String
    
    var body: some View {
        HStack {
            Text(informationText)
                .font(.body)
                .foregroundColor(.customBlack)
            Spacer()
            Image(systemName: "greaterthan")
                .foregroundColor(.customBlack)
        }
        .padding(.horizontal, 17)
        .padding(.vertical, 16)
    }
}

struct DividerCustom: View {
    var body: some View {
        Divider()
            .foregroundColor(.primaryShadowGray)
            .padding(.horizontal, 8)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

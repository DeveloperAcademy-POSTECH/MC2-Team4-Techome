//
//  SettingsView.swift
//  Techome
//
//  Created by 김유나 on 2022/06/15.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @State private var recordNotice: Bool = true
    @State private var warningNotice: Bool = true
    @State private var trendNotice: Bool = true

    
    var body: some View {
        
        NavigationView {
            ZStack(alignment: .leading) {
                Color.backgroundCream.edgesIgnoringSafeArea(.all)
                
                VStack(alignment: .leading, spacing: .zero) {
                    Text("알림")
                        .padding(.leading, 18)
                        .padding(.top, 38)
                        .font(.title3)
                        .foregroundColor(.customBlack)
                    
                    VStack(spacing: .zero) {

                        Toggle("기록 알림", isOn: $recordNotice)
                            .padding(.horizontal, 17)
                            .padding(.vertical, 11)
                            

                        Divider()
                            .foregroundColor(.primaryShadowGray)
                            .padding(.horizontal, 8)
                        
                    
                        Toggle("경고 알림", isOn: $warningNotice)
                            .frame(width: 326, height: 31)
                            .padding(.horizontal, 17)
                            .padding(.vertical, 11)
                        
                        Divider()
                            .foregroundColor(.primaryShadowGray)
                            .padding(.horizontal, 8)
                       
                        Toggle("추이 알림", isOn: $trendNotice)
                            .padding(.horizontal, 17)
                            .padding(.vertical, 11)
                        
                    }
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 7))
                    .padding(.horizontal, 15)
                    .padding(.top, 8)
                    .shadow(color: Color.primaryShadowGray, radius: 4, x: .zero, y: .zero)
                    .font(.body)
                    .foregroundColor(.customBlack)
                    .tint(.primaryBrown)
                    
                    Text("정보")
                        .padding(.leading, 18)
                        .padding(.top, 46)
                        .font(.title3)
                        .foregroundColor(.customBlack)
                    
                    VStack(spacing: .zero) {
                        NavigationLink(destination: {
                            SettingsCompanyView()
                                .navigationBarHidden(true)
                        }){
                        HStack {
                            Text("회사 소개")
                                .font(.body)
                                .foregroundColor(.customBlack)
                            Spacer()
                            Image(systemName: "greaterthan")
                                .foregroundColor(.customBlack)
                        }
                        .padding(.horizontal, 17)
                        .padding(.vertical, 16)

                        }

                        Divider()
                            .foregroundColor(.primaryShadowGray)
                            .padding(.horizontal, 8)
                        
                        NavigationLink(destination: {
                            SettingsOpenSourceView()
                                .navigationBarHidden(true)
                        }){
                        HStack {
                            Text("오픈소스 라이브러리")
                                .font(.body)
                                .foregroundColor(.customBlack)
                            Spacer()
                            Image(systemName: "greaterthan")
                                .foregroundColor(.customBlack)
                        }
                        .padding(.horizontal, 17)
                        .padding(.vertical, 16)
                        }
                        
                        Divider()
                            .foregroundColor(.primaryShadowGray)
                            .padding(.horizontal, 8)
                        
                        NavigationLink(destination: {
                            SettingsPersonalInformationView()
                                .navigationBarHidden(true)
                        }){
                        HStack {
                            Text("개인정보 및 보안 도움말")
                                .font(.body)
                                .foregroundColor(.customBlack)
                            Spacer()
                            Image(systemName: "greaterthan")
                                .foregroundColor(.customBlack)
                        }
                        .padding(.horizontal, 17)
                        .padding(.vertical, 16)
                        }
                        
                        Divider()
                            .foregroundColor(.primaryShadowGray)
                            .padding(.horizontal, 8)
                        
                        NavigationLink(destination: {
                            SettingsAddOpinionView()
                                .navigationBarHidden(true)
                        }){
                        HStack {
                            Text("개발자에게 의견 남기기")
                                .font(.body)
                                .foregroundColor(.customBlack)
                            Spacer()
                            Image(systemName: "greaterthan")
                                .foregroundColor(.customBlack)
                                .font(.body)
                        }
                        .padding(.horizontal, 17)
                        .padding(.vertical, 16)
                        }
                        
                    }
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 7))
                    .padding(.horizontal, 15)
                    .padding(.top, 8)
                    .shadow(color: Color.primaryShadowGray, radius: 4, x: .zero, y: .zero)
                    .font(.body)
                    .foregroundColor(.customBlack)
                    
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

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

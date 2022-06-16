//
//  SettingsCompanyView.swift
//  Techome
//
//  Created by 김유나 on 2022/06/15.
//

import SwiftUI

struct SettingsTeamView: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .leading) {
                Color.backgroundCream.edgesIgnoringSafeArea(.all)
                
                VStack(spacing: .zero) {
                    VStack(alignment: .center, spacing: .zero) {
                        TeamNameLogoRow()
                        MemberGroup()
                        MissionGroup()
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
                .padding(.top, 15)
            }
            .navigationTitle("팀 소개")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading: Button(action: {
                    self.mode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .font(.headline)
                        .foregroundColor(.primaryBrown)
                }
            )
        }
    }
}

struct TeamNameLogoRow: View {
    var body: some View {
        HStack(spacing: 0) {
            Text("택이네")
                .font(.title3)
                .foregroundColor(.customBlack)
            Spacer()
            Image("CaffeineBookIcon")
            
        }
        .padding(.vertical, 25)
        .padding(.horizontal, 17)
    }
}

struct MemberGroup: View {
    
    private let teamMember: String = "놔스닥(박준홍), 닉(김승윤), 메리(김휘원), 진저(김유나), 택(한택환), 포딩(김영우)"
    
    var body: some View {
        VStack(alignment: .leading, spacing: .zero) {
            HStack(spacing: 0) {
                Text("구성원")
                    .font(.body)
                    .foregroundColor(.primaryBrown)
                Spacer()
            }
            
            Text(teamMember)
                .padding(.top, 7)
        }
        .padding(.horizontal, 17)
    }
}

struct MissionGroup: View {
    
    private let teamGather: String = "'택이네'는 '커피'라는 공통 관심사를 가지고 모인 디벨로퍼들로 구성된 팀입니다."
    private let teamMission: String = "사람들이 커피를 포함한 카페인 음료/음식으로 보다 더 활기찬 일상을 만들 수 있도록 함께 머리 모아 고민하는 여정을 함께 해왔습니다."
    
    var body: some View {
        VStack(alignment: .leading, spacing: .zero) {
            HStack(spacing: 0) {
                Text("팀 미션")
                    .font(.body)
                    .foregroundColor(.primaryBrown)
                Spacer()
            }
            .padding(.top, 18)
            
            Text(teamGather)
                .padding(.top, 7)
            
            Text(teamMission)
                .padding(.top, 5)
        }
        .padding(.horizontal, 17)
        .padding(.bottom, 32)
    }
}

struct SettingsTeamView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsTeamView()
    }
}

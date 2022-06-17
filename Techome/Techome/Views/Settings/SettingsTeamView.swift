//
//  SettingsCompanyView.swift
//  Techome
//
//  Created by 김유나 on 2022/06/15.
//

import SwiftUI

struct SettingsTeamView: View {
    
    @Environment(\.presentationMode) var presentation: Binding<PresentationMode>
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .leading) {
                Color.backgroundCream.edgesIgnoringSafeArea(.all)
                
                VStack(spacing: .zero) {
                    VStack(alignment: .center, spacing: .zero) {
                        TeamNameLogoRow()
                        MemberGroup()
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
                    self.presentation.wrappedValue.dismiss()
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
        .padding(.top, 25)
        .padding(.horizontal, 17)
    }
}

struct MemberGroup: View {
    
    private let members: [String] = ["Ginger", "Mary", "Nick", "Noasdaq", "Poding", "Taek"]
    private let roles: [String] = ["택이네 폭주족", "택이네 평화지킴이", "택이네 활력소", "택이네 버팀목", "택이네 과속측정기", "택이네 길잡이"]
    private let motto: [String] = ["뭐든 미친듯이! 한 번 시작하면 끝까지 물고 늘어집니다.", "다양한 것에서 다양한 재미를 느끼며, 나에게 온 모든 일을 즐깁니다.", "현재를 만끽하자! 매 순간을 진심으로 대하고 열심히 나아갑니다.", "오늘은 어제보다 행복하기 위해 노력합니다.", "대체 불가능한 디벨로퍼가 되자!", "WWDC 2022 Winner"]
                                              
    var body: some View {
        VStack(alignment: .leading, spacing: .zero) {
            ForEach(0..<members.count, id: \.self) { member in
                HStack(spacing: .zero) {
                    Text(members[member])
                        .font(.subheadline)
                        .foregroundColor(.customBlack)
                    Text(roles[member])
                        .font(.caption)
                        .foregroundColor(.secondaryTextGray)
                        .padding(.leading, 5)
                        .padding(.top, 2)
                    Spacer()
                }
                .padding(.top, 16)
                
                Text(motto[member])
                    .font(.caption)
                    .foregroundColor(.primaryBrown)
                    .padding(.top, 3)
            }
        }
        .padding(.horizontal, 17)
        .padding(.bottom, 25)
    }
}

struct SettingsTeamView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsTeamView()
    }
}

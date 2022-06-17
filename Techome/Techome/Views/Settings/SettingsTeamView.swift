//
//  SettingsCompanyView.swift
//  Techome
//
//  Created by 김유나 on 2022/06/15.
//

import SwiftUI

struct SettingsTeamLayoutValue {
    
    struct Padding {
        static let cardTop: CGFloat = 23
        static let overallHorizontal: CGFloat = 15
        static let teamNameHorizontal: CGFloat = 17
        static let teamNameVertical: CGFloat = 25
        static let memberGroupHorizontal: CGFloat = 17
        static let memberGroupBottom: CGFloat = 9
        static let memberRoleBetween: CGFloat = 5
        static let roleTop: CGFloat = 2
        static let mottoTop: CGFloat = 3
        static let mottoBottom: CGFloat = 16
    }
    
    struct Radius {
        static let card: CGFloat = 7
        static let cardShadow: CGFloat = 4
    }
}

struct SettingsTeamView: View {
    
    @Environment(\.presentationMode) var presentation: Binding<PresentationMode>
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .leading) {
                Color.backgroundCream.edgesIgnoringSafeArea(.all)
                
                VStack(spacing: .zero) {
                    Card()
                    Spacer()
                }
                .padding(.top, SettingsTeamLayoutValue.Padding.cardTop)
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

struct Card: View {
    var body: some View {
        VStack(alignment: .leading, spacing: .zero) {
            TeamNameRow()
            MemberGroup()
        }
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: SettingsTeamLayoutValue.Radius.card))
        .padding(.horizontal, SettingsTeamLayoutValue.Padding.overallHorizontal)
        .shadow(color: .primaryShadowGray, radius: SettingsTeamLayoutValue.Radius.cardShadow, x: .zero, y: .zero)
        .foregroundColor(.customBlack)
    }
}

struct TeamNameRow: View {
    var body: some View {
        HStack(spacing: .zero) {
            Text("택이네")
                .font(.title3)
            Spacer()
            Image("TeamLogo")
        }
        .padding(.horizontal, SettingsTeamLayoutValue.Padding.teamNameHorizontal)
        .padding(.vertical, SettingsTeamLayoutValue.Padding.teamNameVertical)
    }
}

struct MemberGroup: View {
    
    private let members: [String] = ["Ginger", "Mary", "Nick", "Noasdaq", "Poding", "Taek"]
    private let roles: [String] = ["택이네 폭주족", "택이네 평화지킴이", "택이네 활력소", "택이네 버팀목", "택이네 과속측정기", "택이네 길잡이"]
    private let mottos: [String] = ["뭐든 미친듯이! 한 번 시작하면 끝까지 물고 늘어집니다.", "다양한 것에서 다양한 재미를 느끼며, 나에게 온 모든 일을 즐깁니다.", "현재를 만끽하자! 매 순간을 진심으로 대하고 열심히 나아갑니다.", "오늘은 어제보다 행복하기 위해 노력합니다.", "대체 불가능한 디벨로퍼가 되자!", "WWDC 2022 Winner"]
    
    var body: some View {
        VStack(alignment: .leading, spacing: .zero) {
            ForEach(0..<members.count, id: \.self) { member in
                HStack(spacing: .zero) {
                    Text(members[member])
                        .font(.subheadline)
                    
                    Text(roles[member])
                        .font(.caption)
                        .foregroundColor(.secondaryTextGray)
                        .padding(.leading, SettingsTeamLayoutValue.Padding.memberRoleBetween)
                        .padding(.top, SettingsTeamLayoutValue.Padding.roleTop)
                    
                    Spacer()
                }
                
                Text(mottos[member])
                    .font(.caption)
                    .foregroundColor(.primaryBrown)
                    .padding(.top, SettingsTeamLayoutValue.Padding.mottoTop)
                    .padding(.bottom, SettingsTeamLayoutValue.Padding.mottoBottom)
            }
        }
        .padding(.horizontal, SettingsTeamLayoutValue.Padding.memberGroupHorizontal)
        .padding(.bottom, SettingsTeamLayoutValue.Padding.memberGroupBottom)
    }
}

struct SettingsTeamView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsTeamView()
    }
}

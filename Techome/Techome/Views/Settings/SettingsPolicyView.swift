//
//  SettingsPersonalInformationView.swift
//  Techome
//
//  Created by 김유나 on 2022/06/15.
//

import SwiftUI

struct SettingsPolicyLayoutValue {
    struct Padding {
        static let cardTop: CGFloat = 23
        static let overallHorizontal: CGFloat = 15
        static let dividerHorizontal: CGFloat = 17
        static let dividerVertical: CGFloat = 20
        static let introTop: CGFloat = 20
        static let policyLabelBottom: CGFloat = 5
        static let policyContentBottom: CGFloat = 20
        static let cardContentHorizantal: CGFloat = 17
    }
    
    struct Radius {
        static let card: CGFloat = 7
        static let cardShadow: CGFloat = 4
    }
}

struct SettingsPolicyView: View {
    
    @Environment(\.presentationMode) var presentation: Binding<PresentationMode>
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .leading) {
                Color.backgroundCream.edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    PolicyCard()
                }
            }
            .navigationTitle("개인정보 처리방침")
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

struct PolicyCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: .zero) {
            PolicyIntro()
            
            Divider()
                .foregroundColor(.primaryShadowGray)
                .padding(.horizontal, SettingsPolicyLayoutValue.Padding.dividerHorizontal)
                .padding(.vertical, SettingsPolicyLayoutValue.Padding.dividerVertical)
                
            PolicyContents()
        }
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: SettingsPolicyLayoutValue.Radius.card))
        .shadow(color: Color.primaryShadowGray, radius: SettingsPolicyLayoutValue.Radius.cardShadow, x: .zero, y: .zero)
        .padding(.horizontal, SettingsPolicyLayoutValue.Padding.overallHorizontal)
        .padding(.top, SettingsPolicyLayoutValue.Padding.cardTop)
    }
}

struct PolicyIntro: View {
    
    private let intro: String = "TECHOME의 어플리케이션은 개인정보보호법에 따라 이용자들의 개인정보 보호 및 권익을 보호하고자 다음과 같은 처리방침을 두고 있습니다. 당사는 개인정보처리방침을 개정하는 경우 앱 화면을 통하여 공지할 것입니다."
    
    var body: some View {
        Text(intro)
            .font(.caption)
            .foregroundColor(.secondaryTextGray)
            .padding(.horizontal, SettingsPolicyLayoutValue.Padding.cardContentHorizantal)
            .padding(.top, SettingsPolicyLayoutValue.Padding.introTop)
    }
}

struct PolicyContents: View {
    
    private let policyLabel: [String] = ["1. 개인정보의 처리 목적", "2. 개인정보 파일 현황", "3. 개인정보의 처리 및 보유기간", "4. 개인정보의 제3자 제공에 관한 사항", "5. 개인정보처리 위탁", "6. 정보주체의 권리, 의무 및 그 행사방법", "7. 개인정보의 파기", "8. 타사 모듈 사용에 대한 안내", "9. 개인정보 보호책임자 작성"]
    
    private let policyContent: [String] = ["본 어플리케이션은 개인정보를 수집하지 않는 독립 실행형 어플리케이션으로 별도의 서버를 운영하거나 정보를 수집하지 않습니다. 당사는 iOS 서비스 기능을 이용하기 위한 기능에서 특정 개인과 직접적인 관련이 없는, 개인식별이 불가능한 정보를 수집할 수 있습니다. 당사에서 개인정보를 별도로 저장하거나 이용하지 않습니다.", "당사는 별도의 개인정보 파일을 사용하지 않으며 저장하지도 않습니다. 당사는 쿠키를 저장하지 않으며 이용하지 않습니다.", "당사는 개인정보를 직접적으로 저장하거나 보유하지 않습니다. 따라서 당사는 이용자의 개인정보를 처리하는 내용도 보유기간도 없습니다.", "당사는 개인정보를 제3자에게 제공하지 않고 있습니다.", "당사는 개인정보를 위탁하고 있지 않습니다.", "이용자는 개인정보주체로서 아래와 같은 권리를 행사할 수 있습니다.\n1) 개인정보 열람요구\n2) 오류 등이 있을 경우 정정 요구\n3) 삭제요구\n4) 처리 정지 요구 당사는 개인정보를 저장하거나 위탁하지 않습니다.", "당사의 어플리케이션은 독립 실행 방식의 어플리케이션으로 별도의 서버를 사용하지 않고 있습니다. 또한 개인정보를 저장하지 않으므로 파기할 것이 없습니다. 그러나 사용자가 원할 경우 어플리케이션을 삭제함으로써 모든 데이터를 파기할 수 있습니다.", "탑재된 타사 서비스 모듈은 없습니다.", "이메일 techomeada@gmail.com"]
    
    var body: some View {
        ForEach(0..<policyLabel.count, id: \.self) { labelIndex in
            VStack(alignment: .leading, spacing: .zero) {
                Text(policyLabel[labelIndex])
                    .padding(.bottom, SettingsPolicyLayoutValue.Padding.policyLabelBottom)
                Text(policyContent[labelIndex])
                    .font(.caption)
                    .padding(.bottom, SettingsPolicyLayoutValue.Padding.policyContentBottom)
            }
            .font(.subheadline)
            .foregroundColor(.customBlack)
            .padding(.horizontal, SettingsPolicyLayoutValue.Padding.cardContentHorizantal)
        }
    }
}

struct SettingsPolicyView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsPolicyView()
    }
}


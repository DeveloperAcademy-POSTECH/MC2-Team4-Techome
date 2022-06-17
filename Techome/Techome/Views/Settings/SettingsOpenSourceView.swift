//
//  SettingsOpenSourceView.swift
//  Techome
//
//  Created by 김유나 on 2022/06/15.
//

import SwiftUI

struct SettingsOpenSourceLayoutValue {
    struct Padding {
        static let cardTop: CGFloat = 23
        static let overallHorizontal: CGFloat = 15
        static let dividerHorizontal: CGFloat = 17
        static let dividerVertical: CGFloat = 20
        static let firstLabelTop: CGFloat = 27
        static let secondLabelTop: CGFloat = 10
        static let cardContentHorizantal: CGFloat = 17
        static let openSourceGroupBottom: CGFloat = 20
        static let nameLinkBetween: CGFloat = 2
    }
    
    struct Radius {
        static let card: CGFloat = 7
        static let cardShadow: CGFloat = 4
    }
}

struct SettingsOpenSourceView: View {
    
    @Environment(\.presentationMode) var presentation: Binding<PresentationMode>
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .leading) {
                Color.backgroundCream.edgesIgnoringSafeArea(.all)
                
                VStack(alignment: .leading, spacing: .zero) {
                    OpenSourceCard()
                    Spacer()
                }
                .padding(.top, SettingsOpenSourceLayoutValue.Padding.cardTop)
            }
            .navigationTitle("오픈소스 라이선스")
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

struct OpenSourceCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: .zero) {
            OpenSourceLabel()
            
            Divider()
                .foregroundColor(.primaryShadowGray)
                .padding(.horizontal, SettingsOpenSourceLayoutValue.Padding.dividerHorizontal)
                .padding(.vertical, SettingsOpenSourceLayoutValue.Padding.dividerVertical)
            
            OpenSourceGroup(name: "SwiftUI BarChart", link: "https://github.com/dawigr/BarChart", copyright: "Copyright © 2020 Roman Baitaliuk / MIT license")
            
            OpenSourceGroup(name: "JSONSaveLoad", link: "https://gist.github.com/norsez/aa3f11c0e875526e5270e7791f3891fb", copyright: "Copyright © 2018 norsez")
            
            OpenSourceGroup(name: "Rounding Specific Corners", link: "https://serialcoder.dev/text-tutorials/swiftui/rounding-specific-corners-in-swiftui-views/", copyright: "Copyright © 2020 SerialCoder.dev / MIT license")
            
            OpenSourceGroup(name: "Sine Wave Shape", link: "https://github.com/MrChens/SineWaveShape?ref=iosexample.com", copyright: "Copyright © 2021 IFunny / MIT license")
            
            OpenSourceGroup(name: "SwiftUI Mail Sheet", link: "https://www.youtube.com/watch?v=S1qM9oNEwLE", copyright: "Copyright © 2020 Coding Potter")
            
        }
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: SettingsOpenSourceLayoutValue.Radius.card))
        .shadow(color: .primaryShadowGray, radius: SettingsOpenSourceLayoutValue.Radius.cardShadow, x: .zero, y: .zero)
        .foregroundColor(.customBlack)
        .padding(.horizontal, SettingsOpenSourceLayoutValue.Padding.overallHorizontal)
    }
}

struct OpenSourceLabel: View {
    var body: some View {
        VStack(alignment: .leading, spacing: .zero) {
            Text("This application is Copyright ©Techome. All rights reserved")
                .font(.caption)
                .padding(.top, SettingsOpenSourceLayoutValue.Padding.firstLabelTop)
            
            Text("The following sets forth attribution notices for third party software that may be contained in this application")
                .padding(.top, SettingsOpenSourceLayoutValue.Padding.secondLabelTop)
        }
        .font(.caption)
        .foregroundColor(.secondaryTextGray)
        .padding(.horizontal, SettingsOpenSourceLayoutValue.Padding.cardContentHorizantal)
    }
}

struct OpenSourceGroup: View {
    
    let name: String
    let link: String
    let copyright: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: .zero) {
            Link(name, destination: URL(string: link)!)
                .font(.headline)
                .foregroundColor(.customBlack)
            
            Text(copyright)
                .font(.caption)
                .foregroundColor(.secondaryTextGray)
                .padding(.top, SettingsOpenSourceLayoutValue.Padding.nameLinkBetween)
        }
        .padding(.horizontal, SettingsOpenSourceLayoutValue.Padding.cardContentHorizantal)
        .padding(.bottom, SettingsOpenSourceLayoutValue.Padding.openSourceGroupBottom)
    }
}

struct SettingsOpenSourceView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsOpenSourceView()
    }
}

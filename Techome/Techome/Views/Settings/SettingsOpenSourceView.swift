//
//  SettingsOpenSourceView.swift
//  Techome
//
//  Created by 김유나 on 2022/06/15.
//

import SwiftUI

struct SettingsOpenSourceView: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .leading) {
                Color.backgroundCream.edgesIgnoringSafeArea(.all)
                
                VStack(alignment: .leading, spacing: .zero) {
                    VStack(alignment: .leading, spacing: .zero) {
                        Text("This application is Copyright ©Techome. All rights reserved")
                            .font(.caption)
                            .foregroundColor(.secondaryTextGray)
                            .padding(.horizontal, 17)
                            .padding(.top, 27)
                        
                        Text("The following sets forth attribution notices for third party software that may be contained in this application")
                            .font(.caption)
                            .foregroundColor(.secondaryTextGray)
                            .padding(.horizontal, 17)
                            .padding(.top, 10)
                        
                        Divider()
                            .foregroundColor(.primaryShadowGray)
                            .padding(.horizontal, 17)
                            .padding(.vertical, 20)
                        
                        OpenSourceGroup(name: "SwiftUI BarChart", link: "https://github.com/dawigr/BarChart", copyright: "Copyright © 2020 Roman Baitaliuk / MIT license")
                        
                        OpenSourceGroup(name: "JSONSaveLoad", link: "https://gist.github.com/norsez/aa3f11c0e875526e5270e7791f3891fb", copyright: "Copyright © 2018 norsez")
                        
                        OpenSourceGroup(name: "Rounding Specific Corners", link: "https://serialcoder.dev/text-tutorials/swiftui/rounding-specific-corners-in-swiftui-views/", copyright: "Copyright © 2020 SerialCoder.dev / MIT license")
                        
                        OpenSourceGroup(name: "Sine Wave Shape", link: "https://github.com/MrChens/SineWaveShape?ref=iosexample.com", copyright: "Copyright © 2021 IFunny / MIT license")
                        
                        OpenSourceGroup(name: "SwiftUI Mail Sheet", link: "https://www.youtube.com/watch?v=S1qM9oNEwLE", copyright: "Copyright © 2020 Coding Potter")
                        
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
            .navigationTitle("오픈소스 라이선스")
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

struct OpenSourceGroup: View {
    
    var name: String
    var link: String
    var copyright: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: .zero) {
            
            Link(name, destination: URL(string: link)!)
                .font(.headline)
                .foregroundColor(.customBlack)
            
//            Link(link, destination: URL(string: link)!)
//                .foregroundColor(.blue)
//                .padding(.top, 5)
//                .font(.caption)
            
            Text(copyright)
                .foregroundColor(.secondaryTextGray)
                .padding(.top, 2)
                .font(.caption)

        }
        .padding(.horizontal, 17)
        .padding(.bottom, 20)
    }
}

struct SettingsOpenSourceView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsOpenSourceView()
    }
}

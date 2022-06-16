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
                        
                        OpenSourceGroup(name: "SwiftUI BarChart", link: "https://github.com/dawigr/BarChart/blob/master/LICENSE", copyright: "Copyright (c) 2020 Roman Baitaliuk", license: "MIT License")
                        
                        OpenSourceGroup(name: "SwiftUI BarChart", link: "https://github.com/dawigr/BarChart/blob/master/LICENSE", copyright: "Copyright (c) 2020 Roman Baitaliuk", license: "MIT License")
                        
                        OpenSourceGroup(name: "SwiftUI BarChart", link: "https://github.com/dawigr/BarChart/blob/master/LICENSE", copyright: "Copyright (c) 2020 Roman Baitaliuk", license: "MIT License")
                        
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
    var license: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: .zero) {
            Text(name)
                .font(.headline)
                .foregroundColor(.customBlack)
            
            Link(link,
                 destination: URL(string: link)!)
            .foregroundColor(.blue)
            .padding(.top, 5)
            .font(.caption)
            
            Text(copyright)
                .foregroundColor(.secondaryTextGray)
                .padding(.top, 2)
                .font(.caption)
            
            Text(license)
                .foregroundColor(.customBlack)
                .font(.caption)
                .padding(.top, 2)
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

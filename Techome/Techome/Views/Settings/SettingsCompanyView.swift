//
//  SettingsCompanyView.swift
//  Techome
//
//  Created by 김유나 on 2022/06/15.
//

import SwiftUI

struct SettingsCompanyView: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .leading) {
                Color.backgroundCream.edgesIgnoringSafeArea(.all)
                
                VStack(alignment: .leading, spacing: .zero) {
                    Text("SettingsCompanyView")
                }
            }
            .navigationTitle("회사 소개")
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

struct SettingsCompanyView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsCompanyView()
    }
}

//
//  SettingsPersonalInformationView.swift
//  Techome
//
//  Created by 김유나 on 2022/06/15.
//

import SwiftUI

struct SettingsPersonalInformationView: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .leading) {
                Color.backgroundCream.edgesIgnoringSafeArea(.all)
                
                VStack(alignment: .leading, spacing: .zero) {
                    Text("SettingsPersonalInformationView")
                }
            }
            .navigationTitle("개인정보 및 보안 도움말")
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

struct SettingsPersonalInformationView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsPersonalInformationView()
    }
}

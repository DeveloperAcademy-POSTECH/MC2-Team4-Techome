//
//  SettingsAddOpinionView.swift
//  Techome
//
//  Created by 김유나 on 2022/06/15.
//

import SwiftUI

struct SettingsAddOpinionView: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .leading) {
                Color.backgroundCream.edgesIgnoringSafeArea(.all)
                
                VStack(alignment: .leading, spacing: .zero) {
                    Text("SettingsAddOpinionView")
                }
            }
            .navigationTitle("개발자에게 의견 남기기")
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

struct SettingsAddOpinionView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsAddOpinionView()
    }
}

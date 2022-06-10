//
//  addCaffeine.swift
//  Techome
//
//  Created by Seungyun Kim on 2022/06/09.
//

import SwiftUI

struct SearchCaffeineView: View {
    @Environment(\.presentationMode) var presentationMode
    let widthPadding = 15.0
    
    var body: some View {
        ZStack(alignment: .top) {
            Color(.white)
                .ignoresSafeArea()
            
            
            Text("카페인 추가하기")
                .fontWeight(.bold)
                .foregroundColor(.black)
                .frame(maxWidth:.infinity, alignment: .center)
                .padding(EdgeInsets(top: widthPadding, leading: 0, bottom: 0, trailing: 0))
            
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("취소")
                    .foregroundColor(.primaryBrown)
                    .padding(EdgeInsets(top: widthPadding, leading: 0, bottom: 0, trailing: widthPadding))
            }
            .frame(maxWidth:.infinity, alignment: .trailing)
        }
    }
}

struct SearchCaffeineView_Previews: PreviewProvider {
    
    static var previews: some View {
        SearchCaffeineView()
    }
}

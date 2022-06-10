//
//  HomeView.swift
//  Techome
//
//  Created by Seungyun Kim on 2022/06/10.
//

import SwiftUI

struct HomeView: View {
    @State var showSheet: Bool = false
    var body: some View {
        ZStack {
            Color(.white)
                .ignoresSafeArea()
            
            Button(action: {
                showSheet.toggle()
            }) {
                Text("카페인 추가하기")
                    .font(.title)
                    .foregroundColor(.black)
                    .padding()
                    .background(Color.white)
                    .fullScreenCover(isPresented: $showSheet, content: {
                        SearchCaffeineView()
                    })
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    
    static var previews: some View {
        HomeView()
    }
}

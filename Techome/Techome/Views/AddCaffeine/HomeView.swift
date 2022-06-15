//
//  HomeView.swift
//  Techome
//
//  Created by Seungyun Kim on 2022/06/10.
//

import SwiftUI

struct HomeView: View {
    
    private var searchCaffeineStateHolder = SearchCaffeineStateHolder()
    
    @State var isShowedSheet: Bool = false
    
    var body: some View {
        ZStack {
            Color(.white)
                .ignoresSafeArea()
            
            Button(action: {
                isShowedSheet.toggle()
            }) {
                Text("카페인 추가하기")
                    .font(.title)
                    .foregroundColor(.black)
                    .padding()
                    .background(Color.white)
                    .fullScreenCover(isPresented: $isShowedSheet, content: {
                        SearchCaffeineView()
                            .environmentObject(searchCaffeineStateHolder)
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

//
//  MainView.swift
//  Techome
//
//  Created by Noah Park on 2022/06/15.
//

import SwiftUI

struct MainView: View {
    
    init() {
        UITabBar.appearance().backgroundColor = .white
    }
    
    var body: some View {
        TabView {
            TodayView()
                .navigationBarHidden(true)
                .tabItem {
                    Image(systemName: "1.square.fill")
                    Text("투데이")
                }
            CaffeineBookView()
                .tabItem {
                    Image(systemName: "2.square.fill")
                    Text("카페인북")
                }
            TrendView()
                .tabItem {
                    Image(systemName: "3.square.fill")
                    Text("리포트")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

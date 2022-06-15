//
//  MainView.swift
//  Techome
//
//  Created by Noah Park on 2022/06/15.
//

import SwiftUI

struct MainView: View {
    
    var todayStates = TodayStatesHolder()
    
    init() {
        UITabBar.appearance().backgroundColor = .white
    }
    
    var body: some View {
        TabView {
            TodayView()
                .environmentObject(todayStates)
                .navigationBarHidden(true)
                .tabItem {
                    Image(systemName: "1.square.fill")
                    Text("투데이")
                }
            Text("카페인북 view가 여기 들어와야 해요.")
                .tabItem {
                    Image(systemName: "2.square.fill")
                    Text("카페인북")
                }
            Text("리포트 view가 여기 들어와야 해요.")
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

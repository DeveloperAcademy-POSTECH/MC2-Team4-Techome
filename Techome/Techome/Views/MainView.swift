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
    
    @ObservedObject private var todayStates: TodayStatesHolder = TodayStatesHolder()
    @State var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            TodayView()
                .environmentObject(todayStates)
                .navigationBarHidden(true)
                .tabItem {
                    Image(systemName: "1.square.fill")
                    Text("투데이")
                }
                .tag(0)
            CaffeineBookView()
                .tabItem {
                    Image(systemName: "2.square.fill")
                    Text("카페인북")
                }
                .tag(1)
            TrendView()
                .tabItem {
                    Image(systemName: "3.square.fill")
                    Text("리포트")
                }
                .tag(2)
        }
        .onChange(of: selectedTab) { newValue in
            if newValue == 0 {
                todayStates.setRemainingAmount()
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

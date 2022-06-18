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
//        UITabBar.appearance().barTintColor =
    }
    
    @ObservedObject private var todayStates: TodayStatesHolder = TodayStatesHolder()
    @State var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            TodayView()
                .environmentObject(todayStates)
                .navigationBarHidden(true)
                .tabItem {
                    selectedTab == 0 ? Image("TodaySelected") : Image("Today")
                    Text("투데이")
                }
                .tag(0)
            CaffeineBookView()
                .tabItem {
                    selectedTab == 1 ? Image("CaffeineBookSelected") : Image("CaffeineBook")
                    Text("카페인북")
                }
                .tag(1)
            TrendView()
                .tabItem {
                    selectedTab == 2 ? Image("ReportSelected") : Image("Report")
                    Text("리포트")
                }
                .tag(2)
        }
        .accentColor(.secondaryBrown)
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

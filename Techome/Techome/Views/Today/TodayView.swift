//
//  TodayView.swift
//  Techome
//
//  Created by Noah Park on 2022/06/13.
//

import SwiftUI
import SineWaveShape

struct MainView: View {
    
    init() {
        UITabBar.appearance().backgroundColor = .white
    }
    
    var body: some View {
        NavigationView {
            TabView {
                TodayView()
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
}


struct TodayView: View {
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                BackgroundAnimationView()
                VStack(spacing: 0) {
                    TodayViewTopBottons(geometry: geometry)
                    Spacer()
                }
            }
            .ignoresSafeArea(.all)
        }
    }
}

struct BackgroundAnimationView: View {
    let screenSize = UIScreen.main.bounds
    
    var body: some View {
        ZStack {
            Color.gaugeBackgroundGray
            SineWaveShape(percent: 0.4, strength: 30, frequency: 7, phase: 0)
                .fill(Color.primaryBrown)
                                    .offset(y: CGFloat(1) * 2)
                                    .animation(.linear(duration: 1.0).repeatForever(autoreverses: false))
            Image("TodayGauge")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: screenSize.width)
        }
    }
}

struct TodayViewTopBottons: View {
    let geometry: GeometryProxy
    
    var body: some View {
        HStack(spacing: 0) {
            Spacer()
            Button {
                print("add sideEffect button pressed")
            } label: {
                Image("AddSideEffectViewIcon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 35)
                    .padding(.top, geometry.safeAreaInsets.top)
            }
            .padding(.trailing, 18)
            Button {
                print("add setting button pressed")
            } label: {
                Image(systemName: "gearshape.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 31)
                    .padding(.top, geometry.safeAreaInsets.top)
                    .foregroundColor(.primaryBrown)
            }
        }
        .padding(.top, 9)
        .padding(.trailing, 30)
        
    }
}



struct TodayView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

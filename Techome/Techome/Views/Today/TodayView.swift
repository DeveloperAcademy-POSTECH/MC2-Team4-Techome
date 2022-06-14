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


struct TodayView: View {
    @State private var caffeinePercent: Double = 0.5
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                BackgroundAnimationView(caffeinePercent: $caffeinePercent)
                VStack(spacing: 0) {
                    TodayViewTopBottons(caffeinePercent: $caffeinePercent, geometry: geometry)
                        .padding(.top, 9)
                        .padding(.trailing, 30)
                        .padding(.bottom, 25)
                    RemainingCaffeinStatement()
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.trailing, 30)
                        .padding(.bottom, 374)
                    ExhaustTimeStatement()
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.trailing, 30)
                        .padding(.bottom, 40)
                    AddCaffeineButton()
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.trailing, 30)
                        .padding(.bottom, 100)
                }
            }
            .ignoresSafeArea()
            
        }
    }
}

struct BackgroundAnimationView: View {
    @Binding var caffeinePercent: Double
    @State var phase: Double = 0
    let screenSize = UIScreen.main.bounds
    var percent = 0.4
    
    
    var body: some View {
        ZStack {
            Color.gaugeBackgroundGray
            SineWaveShape(percent: caffeinePercent, strength: 30, frequency: 7, phase: self.phase)
                .fill(Color.secondaryBrown)
                .offset(y: CGFloat(1) * 2)
                .animation(.linear(duration: 3).repeatForever(autoreverses: false), value: phase)
            Image("TodayGauge")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: screenSize.height)
        }
        .onAppear {
            phase = .pi * 2
        }
    }
}

struct TodayViewTopBottons: View {
    @Binding var caffeinePercent: Double
    let geometry: GeometryProxy
    
    var body: some View {
        HStack(spacing: 0) {
            Spacer()
            Button {
                print("add sideEffect button pressed")
                caffeinePercent -= 0.1 // 애니메이션 Test를 위한 임시 로직)
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
                caffeinePercent += 0.1 // 애니메이션 Test를 위한 임시 로직
            } label: {
                Image(systemName: "gearshape.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 31)
                    .padding(.top, geometry.safeAreaInsets.top)
                    .foregroundColor(.primaryBrown)
            }
        }
    }
}

struct RemainingCaffeinStatement: View {
    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .firstTextBaseline, spacing: 0) {
                Text("몸속에")
                    .font(.title3)
                    .padding(.trailing, 8)
                Text("137")
                    .font(.system(size: 53).bold())
                    .foregroundColor(.primaryBrown)
                Text("mg의")
                    .font(.title3)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            Text("카페인이 남아있고")
                .font(.title3)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
}

struct ExhaustTimeStatement: View {
    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .firstTextBaseline, spacing: 0) {
                Text("오후 9시 15분")
                    .font(.system(size: 30).bold())
                    .foregroundColor(.primaryBrown)
                Text("에")
                    .font(.title3)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            Text("모두 배출되요")
                .font(.title3)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
}

struct AddCaffeineButton: View {
    var body: some View {
        VStack(spacing: 0) {
            Button {
                // TODO: modal addCaffeine view
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 7)
                        .aspectRatio(CGSize(width: 4.0, height: 1.0), contentMode: .fit)
                        .foregroundColor(.primaryBrown)
                    Text("카페인 추가하기")
                        .font(.body.bold())
                        .foregroundColor(.white)
                }
                
            }
            .padding(.bottom, 10)
            Text("오늘 총 300mg 섭취")
                .font(.caption)
        }
    }
}


struct TodayView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

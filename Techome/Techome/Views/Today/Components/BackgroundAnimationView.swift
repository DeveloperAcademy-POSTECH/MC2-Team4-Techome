//
//  BackgroundAnimationView.swift
//  Techome
//
//  Created by Noah Park on 2022/06/15.
//

import SwiftUI
import SineWaveShape

struct BackgroundAnimationView: View {
    @ObservedObject var todayStates: TodayStatesHolder
    @State var phase: Double = 0
    private let screenSize: CGRect = UIScreen.main.bounds
    private let waveStrength: Double = 30.0 // 물결 강도
    private let waveFrequency: Double = 7.0 // 물결 빈도
    let geometry: GeometryProxy
    
    
    
    var body: some View {
        ZStack {
            Color.gaugeBackgroundGray
            SineWaveShape(percent: 1 - todayStates.getRemainingPercentage(), strength: waveStrength, frequency: waveFrequency, phase: self.phase)
                .fill(Color.gaugeBrown)
                .animation(.linear(duration: 3).repeatForever(autoreverses: false), value: phase)
            Image("TodayGauge")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: geometry.size.height)
        }
        .onAppear {
            phase = .pi * 2
        }
    }
}

struct BackgroundAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        let todayStates: TodayStatesHolder = TodayStatesHolder()
        GeometryReader { geometry in
            BackgroundAnimationView(todayStates: todayStates, geometry: geometry)
                .previewLayout(.sizeThatFits)
        }
    }
}

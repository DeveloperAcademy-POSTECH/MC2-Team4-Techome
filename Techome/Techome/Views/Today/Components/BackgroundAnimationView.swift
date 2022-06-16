//
//  BackgroundAnimationView.swift
//  Techome
//
//  Created by Noah Park on 2022/06/15.
//

import SwiftUI
import SineWaveShape

struct BackgroundAnimationView: View {
    @State var phase: Double = 0
    @Binding var caffeinePercent: Double
    private let screenSize: CGRect = UIScreen.main.bounds
    private let strength: Double = 30.0 // 물결 강도입니다.
    private let frequency: Double = 7.0 // 물결 횟수입니다.
    let geometry: GeometryProxy
    
    
    
    var body: some View {
        ZStack {
            Color.gaugeBackgroundGray
            SineWaveShape(percent: caffeinePercent, strength: strength, frequency: frequency, phase: self.phase)
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
        GeometryReader { geometry in
            BackgroundAnimationView(caffeinePercent: .constant(0.5), geometry: geometry)
                .previewLayout(.sizeThatFits)
        }
    }
}

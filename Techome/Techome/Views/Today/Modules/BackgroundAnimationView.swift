//
//  BackgroundAnimationView.swift
//  Techome
//
//  Created by Noah Park on 2022/06/15.
//

import SwiftUI
import SineWaveShape

struct BackgroundAnimationView: View {
    @Binding var caffeinePercent: Double
    private let screenSize: CGRect = UIScreen.main.bounds
    private let percent: Double = 0.4
    private let strength: Double = 30.0
    private let frequency: Double = 7.0
    @State var phase: Double = 0
    
    
    var body: some View {
        ZStack {
            Color.gaugeBackgroundGray
            SineWaveShape(percent: caffeinePercent, strength: strength, frequency: frequency, phase: self.phase)
                .fill(Color.secondaryBrown)
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

struct BackgroundAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundAnimationView(caffeinePercent: .constant(0.5))
    }
}

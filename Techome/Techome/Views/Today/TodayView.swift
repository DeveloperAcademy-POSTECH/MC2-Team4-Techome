//
//  TodayView.swift
//  Techome
//
//  Created by Noah Park on 2022/06/13.
//

import SwiftUI

struct TodayView: View {
    var body: some View {
        ZStack {
            Color.gaugeBackgroundGray.ignoresSafeArea(.all)
            Image("TodayGauge")
                .resizable()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main
                    .bounds.height)
        }
        
    }
}

struct TodayView_Previews: PreviewProvider {
    static var previews: some View {
        TodayView()
    }
}

//
//  TrendView.swift
//  Techome
//
//  Created by 한택환 on 2022/06/09.
//

import SwiftUI

struct TrendView: View {
    var body: some View {
        TrendChart()
    }
}

struct TrendChart: View {
    let chartWidth: CGFloat = UIScreen.main.bounds.width - 30
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyHStack {
                TabView {
                    ForEach(0..<5) {index in
                        VStack(alignment: .leading, spacing: 0) {
                            Text("하루 평균 섭취량")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            HStack {
                                Text("360")
                                    .font(.largeTitle)
                                    .foregroundColor(.black)
                            }
                        }
                    }
                }
                .frame(width: chartWidth, height: chartWidth * 1.26, alignment: .center)
                .shadow(color: .customBlack, radius: 4)
                .tabViewStyle(.page(indexDisplayMode: .never))
            }
            
        }
    }
}

struct SideEffectRecordByDay: View {
    var body: some View {
        Text("SideEffect")
    }
}

struct CaffeineRecordByDay: View {
    var body: some View {
        Text("CaffeineList")
    }
}

struct TrendView_Previews: PreviewProvider {
    static var previews: some View {
        TrendView()
    }
}

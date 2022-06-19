//
//  ChartBar.swift
//  Techome
//
//  Created by Yeongwoo Kim on 2022/06/19.
//

import SwiftUI

struct ChartBar: View {
    let height: Int
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            
            RoundedRectangle(cornerRadius: 5)
                .frame(width: ChartViewLayoutValue.Size.Chart.barWidth, height: CGFloat(height), alignment: .center)
                .foregroundColor(.gaugeBrown)
        }
        .frame(width: ChartViewLayoutValue.Size.Chart.chartCellWidth, height: ChartViewLayoutValue.Size.Chart.chartLineHeight)
    }
}

struct ChartBar_Previews: PreviewProvider {
    static var previews: some View {
        ChartBar(height: 192)
            .scaledToFit()
    }
}

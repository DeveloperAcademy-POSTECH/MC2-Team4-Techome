//
//  ChartForeground.swift
//  Techome
//
//  Created by Yeongwoo Kim on 2022/06/19.
//

import SwiftUI

struct ChartForeground: View {
    @EnvironmentObject var stateHolder: ChartStateHolder
    let intakeManager = IntakeManager.shared
    let startDate: Date
    let day = 24 * 60 * 60
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                let weeklyCaffeineAmount = stateHolder.getWeeklyCaffeineAmount(date: startDate)
                let maxHeight = stateHolder.getMaxAmountInWeek(date: startDate)
                
                Divider()
                    .frame(width: 1, height: ChartViewLayoutValue.Size.Chart.chartLineHeight)
                
                ForEach(weeklyCaffeineAmount.indices, id: \.self) { index in
                    if weeklyCaffeineAmount[index] != 0 {
                        ChartBar(height: 192 * weeklyCaffeineAmount[index] / maxHeight)
                            .onTapGesture {
                                stateHolder.showRecord(date: startDate.addingTimeInterval(TimeInterval(day * index)))
                            }
                    } else {
                        Spacer()
                            .frame(width: ChartViewLayoutValue.Size.Chart.chartCellWidth)
                    }
                    
                    Divider()
                        .frame(width: 1, height: ChartViewLayoutValue.Size.Chart.chartLineHeight)
                }
            }
            
            Divider()
                .frame(width: ChartViewLayoutValue.Size.Chart.chartLineWidth)
            
            Spacer()
        }
        .frame(width: ChartViewLayoutValue.Size.Chart.chartLineWidth,height: ChartViewLayoutValue.Size.Chart.chartLineHeight)
    }
}

struct ChartForeground_Previews: PreviewProvider {
    static var previews: some View {
        ChartForeground(startDate: Date())
            .environmentObject(ChartStateHolder())
    }
}

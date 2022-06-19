//
//  WeekChart.swift
//  Techome
//
//  Created by Yeongwoo Kim on 2022/06/19.
//

import SwiftUI

struct WeekChart: View {
    let intakeManager = IntakeManager.shared
    @EnvironmentObject var stateHolder: ChartStateHolder
    let startDate: Date
    let day = 24 * 60 * 60
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 5)
                .foregroundColor(.white)
            
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    WeekAverageCaffeineAmount(startDate: startDate)
                        .padding(.top, 16)
                        .padding(.leading, 15)
                    Spacer()
                }
               
                HStack(spacing: 0) {
                    Spacer()
                    Circle()
                        .foregroundColor(.customRed)
                        .frame(width: 12)
                        .padding(.trailing, 7)
                    Text("부작용")
                        .padding(.trailing, 14)
                }
                
                ChartForeground(startDate: startDate)
                
                Spacer()
            }
        }
        .frame(width: ChartViewLayoutValue.Size.Chart.width, height: ChartViewLayoutValue.Size.Chart.height, alignment: .center)
        .shadow(color: .primaryShadowGray, radius: 4, x: 0, y: 0)
    }
}

struct WeekChart_Previews: PreviewProvider {
    static var previews: some View {
        WeekChart(startDate: Date())
            .environmentObject(ChartStateHolder())
    }
}

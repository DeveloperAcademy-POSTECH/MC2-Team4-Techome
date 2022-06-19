//
//  WeekAverageCaffeineAmount.swift
//  Techome
//
//  Created by Yeongwoo Kim on 2022/06/19.
//

import SwiftUI

struct WeekAverageCaffeineAmount: View {
    @EnvironmentObject var stateHolder: ChartStateHolder
    let intakeManager = IntakeManager.shared
    let startDate: Date
    let day = 24 * 60 * 60
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("하루 평균 섭취량")
                .font(.system(size: 15))
                .padding(.bottom, 3)
            
            HStack(spacing: 0) {
                Text(String(stateHolder.getWeeklyAverageCaffeineAmount(date: startDate)))
                    .font(.system(size: 35))
                Text("mg")
                    .font(.system(size: 17))
                    .foregroundColor(.secondaryTextGray)
            }
            .padding(.bottom, 10)
            
            HStack(spacing: 0) {
                Text(Formatter.koreanYearMonthDay.string(from: startDate))
                    .font(.system(size: 17))
                    .foregroundColor(.secondaryTextGray)
                Text(" ~ ")
                    .font(.system(size: 17))
                    .foregroundColor(.secondaryTextGray)
                Text(Formatter.koreanMonthDay.string(from: startDate.addingTimeInterval(TimeInterval(day * 7))))
                    .font(.system(size: 17))
                    .foregroundColor(.secondaryTextGray)
            }
        }
    }
}

struct WeekAverageCaffeineAmount_Previews: PreviewProvider {
    static var previews: some View {
        WeekAverageCaffeineAmount(startDate: Date())
            .environmentObject(ChartStateHolder())
    }
}

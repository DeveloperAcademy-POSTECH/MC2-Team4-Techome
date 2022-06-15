//
//  RemainingCaffeineStatement.swift
//  Techome
//
//  Created by Noah Park on 2022/06/15.
//

import SwiftUI

struct RemainingCaffeineStatement: View {
    @EnvironmentObject private var todayStates: TodayStatesHolder
    
    var body: some View {
        VStack(spacing: .zero) {
            HStack(alignment: .firstTextBaseline, spacing: .zero) {
                Text("몸속에")
                    .font(.title3)
                    .padding(.trailing, TodayLayoutValue.Padding.RemainingStatement.textVInterval)
                Text("\(Int(todayStates.remainingAmount))")
                    .font(.system(size: TodayLayoutValue.Size.remainingTextSize).bold())
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

struct RemainingCaffeineStatement_Previews: PreviewProvider {
    static var previews: some View {
        RemainingCaffeineStatement()
    }
}

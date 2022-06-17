//
//  ExhaustTimeStatement.swift
//  Techome
//
//  Created by Noah Park on 2022/06/15.
//

import SwiftUI

struct ExhaustTimeStatement: View {
    @ObservedObject var todayStates: TodayStatesHolder
    
    var body: some View {
        VStack(spacing: .zero) {
            HStack(alignment: .firstTextBaseline, spacing: .zero) {
                Text("\(todayStates.getTimeToDischarge())")
                    .font(.system(size: TodayLayoutValue.Size.exhaustTextSize).bold())
                    .foregroundColor(.primaryBrown)
                Text("에")
                    .font(.title3)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            Text("모두 배출돼요")
                .font(.title3)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
}

struct ExhaustTimeStatement_Previews: PreviewProvider {
    static var previews: some View {
        let todayStates: TodayStatesHolder = TodayStatesHolder()
        ExhaustTimeStatement(todayStates: todayStates)
            .previewLayout(.sizeThatFits)
    }
}

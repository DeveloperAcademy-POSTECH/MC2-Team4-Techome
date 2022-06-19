//
//  ChartView_P.swift
//  Techome
//
//  Created by Yeongwoo Kim on 2022/06/19.
//

import SwiftUI

struct ChartView_P: View {
    @StateObject var stateHolder = ChartStateHolder()
    @State var selectedTab = 0
    
    var body: some View {
        ZStack {
            Color.backgroundCream
                .ignoresSafeArea()
            
            VStack(spacing: .zero) {
                TabView(selection: $selectedTab) {
                    ForEach(stateHolder.dateArray.indices, id: \.self) { index in
                        WeekChart(startDate: stateHolder.dateArray[index])
                            .environmentObject(stateHolder)
                            .tag(index)
                    }
                }
                .onChange(of: selectedTab) { _ in
                    stateHolder.disableList()
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                
                if stateHolder.isShowRecord {
                    ForEach(stateHolder.selectedDaySideEffectRecord, id: \.self) { sideEffect in
                        Text(sideEffect.getSideEffectName())
                    }
                    
                    ForEach(stateHolder.selectedDayIntakeRecord, id: \.self) { intakeRecord in
                        Text(intakeRecord.beverage.name)
                    }
                }
                
                Spacer()
            }
        }
        .frame(width: screenWidth, height: screenHeight, alignment: .center)
        .onAppear {
            selectedTab = stateHolder.dateArray.count - 1
        }
    }
}

struct ChartView_P_Previews: PreviewProvider {
    static var previews: some View {
        ChartView_P()
    }
}

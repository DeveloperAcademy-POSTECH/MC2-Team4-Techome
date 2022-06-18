//
//  TrendChartView.swift
//  Techome
//
//  Created by 한택환 on 2022/06/14.
//

import SwiftUI
import BarChart

///https://github.com/romanbaitaliuk/BarChart
struct ChartLayoutValue {
    static let chartLabelFontSize: CGFloat = 10
    static let axisLineWidth: CGFloat = 0.5
    static let yAxisSpacing: Double = 30.0
    
    struct ChartIndicatorLayoutValue {
        static let selectionLineHeight: CGFloat = 295
        static let infoRectangleWidth: CGFloat = 130
        static let selectionLineWidth: CGFloat = 2.5
        static let moveSelectionLineY: CGFloat = -10
        static let drawSelectionLineY: CGFloat = 170
    }
}

struct TrendChartView: View {
    
    //MARK: library 필요 변수
    private let config = ChartConfiguration()
    
    @State private var entries = [ChartDataEntry]()
    @State private var xAxisTicksIntervalValue: Double = 1
    @State private var isXAxisTicksHidden: Bool = false
    @Binding var index: Int
    @EnvironmentObject var trendStates: TrendStateHolder
    //var trendStates: TrendStateHolder
    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: TrendViewLayoutValue.Radius.cardRadius)
                .foregroundColor(.white)
                .onTapGesture {
                    trendStates.selectedBarTopCentreLocation = nil
                }
            VStack(alignment: .leading, spacing: .zero) {
                selectionIndicatorView()
                
                SelectableBarChartView<SelectionLine>(config: self.config)
                    .onBarSelection { entry, location in
                        if trendStates.selectedBarTopCentreLocation == location {
                            trendStates.selectedBarTopCentreLocation = nil
                        }
                        else {
                            trendStates.selectedBarTopCentreLocation = location
                            trendStates.selectedEntry = entry
                        }
                    }
                    .selectionView {
                        SelectionLine(location: trendStates.selectedBarTopCentreLocation,
                                      height: ChartLayoutValue.ChartIndicatorLayoutValue.selectionLineHeight)
                        
                    }
                
                    .onAppear() {
                        config.initChartView()
                        config.data.color = trendStates.sideEffectManager.getDailyRecords(date: Date.now).count == 0 ? .tertiaryBrown : .customRed
                        print(trendStates.sideEffectManager.getDailyRecords(date: Date.now).count)
                        //TODO: 차트 데이터 삽입 테스트
                        config.data.entries[4] = SetEntries().inputEntry()
                        config.initTicksColor()
                        config.initTicksStyle()
                        config.initLabelsColor()
                        config.setLabelFont()
                        config.yUnitFormatter()
                        print("+\(index)")
                    }
                    .onDisappear() {
                        trendStates.selectedBarTopCentreLocation = nil
                    }
                    .animation(.easeInOut, value: index)
                    .onReceive([self.isXAxisTicksHidden].publisher.first()) { (value) in
                        self.config.xAxis.ticksColor = value ? Color.clear : .chartBackgroundLineGray
                    }
                    .onReceive([self.xAxisTicksIntervalValue].publisher.first()) { (value) in
                        self.config.xAxis.ticksInterval = Int(value)
                    }
                //selectionCaffeineSideEffectLabelView()
            }.padding(TrendViewLayoutValue.Paddings.chartInsidePadding)
        }
    }
    func selectionIndicatorView() -> some View {
        Group {
            if trendStates.selectedEntry != nil && trendStates.selectedBarTopCentreLocation != nil {
                ChartSelectionIndicatorView(entry: trendStates.selectedEntry!,
                                            location: trendStates.selectedBarTopCentreLocation?.x ?? 0)
            } else {
                Rectangle().foregroundColor(.clear)
            }
        }
        .frame(height: TrendViewLayoutValue.Sizes.chartSelectionIndicatorHeight)
    }
}
//TODO: merge 과정에서 Extension으로 옮길 예정
extension ChartConfiguration {
    
    func initLabelsColor() {
        self.xAxis.labelsColor = .secondaryTextGray
        self.yAxis.labelsColor = .secondaryTextGray
    }
    func setLabelFont() {
        let labelsFont = CTFontCreateWithName(("SFProText-Regular" as CFString), ChartLayoutValue.chartLabelFontSize, nil)
        self.labelsCTFont = labelsFont
    }
    func yUnitFormatter() {
        self.yAxis.formatter = { (value, decimals) in
            let format = value == 0 ? "" : ""
            return String(format: " %.\(decimals)f\(format)", value)
        }
    }
    func initTicksStyle() {
        self.xAxis.ticksStyle = StrokeStyle(lineWidth: ChartLayoutValue.axisLineWidth)
        self.yAxis.ticksStyle = StrokeStyle(lineWidth: ChartLayoutValue.axisLineWidth)
    }
    func initTicksColor() {
        self.xAxis.ticksColor = .chartBackgroundLineGray
        self.yAxis.ticksColor = .chartBackgroundLineGray
    }
    func initChartView() {
        self.data.entries = SetEntries().initEntries()
        self.yAxis.minTicksSpacing = ChartLayoutValue.yAxisSpacing
    }
}



struct SetEntries {
    //@EnvironmentObject var trendStates: TrendStateHolder
    let trendStates = TrendStateHolder()
    private let xAxisLabelCount = 7
    
    //TODO: 임시 formatter
    static func getDayOfWeek(_ today:Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko")
        dateFormatter.dateFormat = "E"
        let currentDateString: String = dateFormatter.string(from: today)
        return currentDateString
    }
    func inputEntry() -> ChartDataEntry {
        let today = trendStates.intakeRecords[0].date
        let caffeineAmountX = trendStates.intakeManager.getTodayIntakeCaffeineAmount()
        let todayOfWeek = SetEntries.getDayOfWeek(today)
        let newEntry = ChartDataEntry(x: todayOfWeek, y: Double(caffeineAmountX))
        return newEntry
    }
//    func getDayOfWeektoInt() -> Int {
//        let selectedDate = trendStates.intakeRecords[0].date
//        let selectedDayOfWeek = getDayOfWeek(selectedDate)
//        let selectedDayOfWeekInt = DayOfWeek.getDayOfWeekIndex(DayOfWeek(rawValue: selectedDayOfWeek) ?? 0)
//        return selectedDayOfWeekInt
//    }
    //TODO: 임시 랜덤 데이터 넣는 함수
    func initEntries() -> [ChartDataEntry] {
        var entries = [ChartDataEntry]()
        let dayOfWeek: [String] = ["일", "월", "화", "수", "목", "금", "토"]
        for data in 0 ..< xAxisLabelCount {
            let randomDouble = 0.0 //Double.random(in: 0..<600)
            let newEntry = ChartDataEntry(x: dayOfWeek[data], y: randomDouble)
            entries.append(newEntry)
        }
        return entries
    }
}

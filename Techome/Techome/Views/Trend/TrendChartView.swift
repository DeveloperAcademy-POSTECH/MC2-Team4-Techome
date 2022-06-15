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
    @State private var selectedBarTopCentreLocation: CGPoint?
    @State private var selectedEntry: ChartDataEntry?
    private let xAxisLabelCount = 7
    @State private var xAxisTicksIntervalValue: Double = 1
    @State private var isXAxisTicksHidden: Bool = false
    
    var isSideEffect: Bool = false
    
    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: TrendViewLayoutValue.Radius.cardRadius)
                .foregroundColor(.white)
                .onTapGesture {
                    selectedBarTopCentreLocation = nil
                }
            VStack(alignment: .leading, spacing: .zero) {
                selectionIndicatorView()
                
                SelectableBarChartView<SelectionLine>(config: self.config)
                    .onBarSelection { entry, location in
                        if selectedBarTopCentreLocation == location {
                            self.selectedBarTopCentreLocation = nil
                        }
                        else {
                            self.selectedBarTopCentreLocation = location
                            self.selectedEntry = entry
                        }
                    }
                    .selectionView {
                        SelectionLine(location: self.selectedBarTopCentreLocation,
                                      height: ChartLayoutValue.ChartIndicatorLayoutValue.selectionLineHeight)
                    }
                    .onAppear() {
                        initChartView()
                        initTicksColor()
                        initTicksStyle()
                        initLabelsColor()
                        setLabelFont()
                        yUnitFormatter()
                    }
                    .onDisappear() {
                        selectedBarTopCentreLocation = nil
                    }
                    .onReceive([self.isXAxisTicksHidden].publisher.first()) { (value) in
                        self.config.xAxis.ticksColor = value ? .clear : .chartBackgroundLineGray
                    }
                    .onReceive([self.xAxisTicksIntervalValue].publisher.first()) { (value) in
                        self.config.xAxis.ticksInterval = Int(value)
                    }
            }.padding(TrendViewLayoutValue.Paddings.chartInsidePadding)
        }
    }
    
    func selectionIndicatorView() -> some View {
        Group {
            if self.selectedEntry != nil && self.selectedBarTopCentreLocation != nil {
                ChartSelectionIndicatorView(entry: self.selectedEntry!,
                                   location: self.selectedBarTopCentreLocation?.x ?? 0)
            } else {
                Rectangle().foregroundColor(.clear)
            }
        }
        .frame(height: TrendViewLayoutValue.Sizes.chartSelectionIndicatorHeight)
    }
    //TODO: 임시 formatter
    func getDayOfWeek(_ today:Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko")
        dateFormatter.dateFormat = "E"
        let currentDateString: String = dateFormatter.string(from: today)
        return currentDateString
    }
    //TODO: 임시 랜덤 데이터 넣는 함수
    func randomEntries() -> [ChartDataEntry] {
        var entries = [ChartDataEntry]()
        let dayOfWeek: [String] = ["일", "월", "화", "수", "목", "금", "토"]
        for data in 0 ..< xAxisLabelCount {
            let randomDouble = Double.random(in: 0..<600)
            let newEntry = ChartDataEntry(x: dayOfWeek[data], y: randomDouble)
            entries.append(newEntry)
        }
        return entries
    }
    //TODO: 임시 빈 데이터 넣는 함수
    func emptyEntries() -> [ChartDataEntry] {
        var entries = [ChartDataEntry]()
        let dayOfWeek: [String] = ["일", "월", "화", "수", "목", "금", "토"]
        for data in 0 ..< xAxisLabelCount {
            let newEntry = ChartDataEntry(x: dayOfWeek[data], y: 600)
            entries.append(newEntry)
        }
        return entries
    }
    func initLabelsColor() {
        config.xAxis.labelsColor = .secondaryTextGray
        config.yAxis.labelsColor = .secondaryTextGray
    }
    func setLabelFont() {
        let labelsFont = CTFontCreateWithName(("SFProText-Regular" as CFString), ChartLayoutValue.chartLabelFontSize, nil)
        config.labelsCTFont = labelsFont
    }
    func yUnitFormatter() {
        config.yAxis.formatter = { (value, decimals) in
            let format = value == 0 ? "" : ""
            return String(format: " %.\(decimals)f\(format)", value)
        }
    }
    func initTicksStyle() {
        config.xAxis.ticksStyle = StrokeStyle(lineWidth: ChartLayoutValue.axisLineWidth)
        config.yAxis.ticksStyle = StrokeStyle(lineWidth: ChartLayoutValue.axisLineWidth)
    }
    func initTicksColor() {
        config.xAxis.ticksColor = .chartBackgroundLineGray
        config.yAxis.ticksColor = .chartBackgroundLineGray
    }
    func initChartView() {
        config.data.entries = randomEntries()
        config.data.color = (isSideEffect ? .customRed : .tertiaryBrown)
        config.yAxis.minTicksSpacing = ChartLayoutValue.yAxisSpacing
    }
}



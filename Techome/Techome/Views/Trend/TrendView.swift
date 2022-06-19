//
//  TrendView.swift
//  Techome
//
//  Created by 한택환 on 2022/06/09.
//

//
import SwiftUI
import BarChart


struct TrendViewLayoutValue {
    
    struct Paddings {
        ///TrendView Paddings
        static let dayRecordPadding: CGFloat = 4
        static let caffeineRecordRowVerticalPadding: CGFloat = 15
        static let caffeineRecordRowHorizontalPadding: CGFloat = 20
        static let chartPadding: CGFloat = 8
        static let textVerticalPadding: CGFloat = 5
        static let averageCaffeineWeekPadding: CGFloat = 7
        static let sideEffectRecordCellHorizontalPadding: CGFloat = 21
        static let sideEffectRecordCellVerticalPadding: CGFloat = 20
        static let averageCaffeineAmountPadding: CGFloat = 15
        static let caffeineRecordAmountUnitPadding: CGFloat = 1
        static let totalListViewPadding: CGFloat = 20
        static let chartInsidePadding: CGFloat = 15
        static let chartIndicatorVertical: CGFloat = 10
    }
    
    ///TrendView Sizes
    struct Sizes {
        static let mainWidth: CGFloat = UIScreen.main.bounds.width
        static let mainHeight: CGFloat = UIScreen.main.bounds.height
        static let cardWidth: CGFloat = UIScreen.main.bounds.width - 30
        static let chartHeight: CGFloat = cardWidth * 1.26
        static let sideEffectRecordHeight: CGFloat = cardWidth / 2.4
        static let sideEffectRecordCellFixedWidth: CGFloat = 46
        static let chartSelectionIndicatorHeight: CGFloat = 83
    }
    ///TrendView Radius
    struct Radius {
        static let cardRadius: CGFloat = 7
        static let shadowRadius: CGFloat = 2
    }
}

struct TrendView: View {
    @StateObject var trendStates: TrendStateHolder = TrendStateHolder()
    @State private var selectedBarTopCentreLocation: CGPoint? = nil
    @State private var selectedEntry: ChartDataEntry? = nil
    
    func isSelectedChartCell() -> Int {
        for entryIndex in 0 ..< 7 {
            if selectedEntry?.y == Double(trendStates.intakeManager.getDailyIntakeCaffeineAmount(date: trendStates.dateOfRecordsByWeek[trendStates.weekChartCount][entryIndex])) && selectedEntry?.x == SetEntries.getDayOfWeek(trendStates.dateOfRecordsByWeek[trendStates.weekChartCount][entryIndex]) {
                return entryIndex
            }
        }
        return 0
    }
    
    struct selectionCaffeineSideEffectLabelView: View {
        @Binding var selectedBarTopCentreLocation: CGPoint?
        @Binding var selectedEntry: ChartDataEntry?
        var body: some View {
            Group {
                if self.selectedEntry != nil && self.selectedBarTopCentreLocation != nil {
                    Group {
                        SideEffectRecordsByDay()
                        CaffeineRecordsByDay()
                    }
                    .background(CardBackground())
                    .padding(.vertical, TrendViewLayoutValue.Paddings.dayRecordPadding)
                }
            }
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.backgroundCream
                    .edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    VStack(spacing: .zero) {
                        TrendChart(trendStates: trendStates, selectedBarTopCentreLocation: $selectedBarTopCentreLocation, selectedEntry: $selectedEntry)
                        selectionCaffeineSideEffectLabelView(selectedBarTopCentreLocation: $selectedBarTopCentreLocation, selectedEntry: $selectedEntry)
                        NavigationLink {
                            TotalListView()
                                .environmentObject(TotalListStateHolder())
                        } label: {
                            Text("전체 리스트 보기")
                                .font(.subheadline)
                                .foregroundColor(.secondaryTextGray)
                                .padding(TrendViewLayoutValue.Paddings.totalListViewPadding)
                        }
                        
                        Spacer()
                    }
                    .navigationTitle("카페인 리포트")
                }
            }
        }
    }
}
class TrendStateHolder: ObservableObject {
    let intakeManager: IntakeManager = IntakeManager.shared
    let sideEffectManager: SideEffectManager = SideEffectManager.shared
    var intakeRecords: [IntakeRecord]
    @Published var ChartWeekIndex: Int = 0
    
    var dateOfRecords: [Date] = [Date]()
    var dateOfRecordsByWeek = [[Date]]()
    var weekChartCount: Int = 0
    var firstDateRecord: Date //= [IntakeRecord]().first?.date ?? Date()
    
    init() {
        intakeRecords = intakeManager.getDailyRecords(date: Date.now)
        firstDateRecord = intakeRecords.first?.date ?? Date()
        
        getDateOfRecordsByWeek()
    }
    //TODO: 리팩토링
    func getDateOfRecords() {
        intakeRecords = intakeManager.getDailyRecords(date: firstDateRecord)
        for intakeRecord in intakeRecords {
            var isSameDate = false
            for dateOfRecord in dateOfRecords {
                if Calendar.current.isDate(intakeRecord.date, inSameDayAs: dateOfRecord) {
                    isSameDate = true
                    break
                }
            }
            if !isSameDate {
                dateOfRecords.append(intakeRecord.date)
            }
        }
    }
    func getDateOfRecordsByWeek() {
        var prepareToAppend = [Date]()
        for index in 0 ... getDayOfWeek() {
            prepareToAppend.insert(Calendar.current.date(byAdding: .day, value: -index, to: firstDateRecord) ?? firstDateRecord, at: 0)
            print("\(index)")
            print(prepareToAppend)
        }
        
        print("-----------------------------------------")
        for index in getDayOfWeek()+1 ..< 7 {
            prepareToAppend.insert(Calendar.current.date(byAdding: .day, value: index, to: firstDateRecord) ?? firstDateRecord, at: 0)
            print("\(index)")
            print(prepareToAppend)
            print("---------------------------------------")

        }
        dateOfRecordsByWeek.append(prepareToAppend)
        print("\(dateOfRecordsByWeek)")
        prepareToAppend = [Date]()
        let firstDayOfSecondWeek = Calendar.current.date(byAdding: .day, value: 7 - getDayOfWeek(), to: firstDateRecord) ?? Date()
        print("------------------adfadf")
        print(firstDateRecord)
        print(firstDayOfSecondWeek)
        var addedDate = firstDayOfSecondWeek
        print("today:\( Date())")
        print("today:\( Date().startOfDay)")
        while addedDate.startOfDay <= Date().startOfDay {
            print("input: \(addedDate)")
            for _ in 0 ..< 7 {
                let newDate = Calendar.current.date(byAdding: .day , value: 1, to: addedDate)
                prepareToAppend.insert(newDate ?? Date(), at: 0)
                addedDate = newDate ?? Date()
            }
            dateOfRecordsByWeek.append(prepareToAppend)
        }
        weekChartCount = dateOfRecordsByWeek.count-1
        print("----------------------")
        print(dateOfRecordsByWeek)
    }
    
    func getDayOfWeek() -> Int {
        return 1
    }
}
enum DayOfWeek: Int {
    case 일 = 0
    case 월 = 1
    case 화 = 2
    case 수 = 3
    case 목 = 4
    case 금 = 5
    case 토 = 6
}
extension Date {
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }
    
    func localDate() -> Date {
        let nowUTC = Date()
        let timeZoneOffset = Double(TimeZone.current.secondsFromGMT(for: nowUTC))
        guard let localDate = Calendar.current.date(byAdding: .second, value: Int(timeZoneOffset), to: nowUTC) else {return Date()}

        return localDate
    }
}

struct TrendChart: View {
    @StateObject var trendStates: TrendStateHolder
    @Binding var selectedBarTopCentreLocation: CGPoint?
    @Binding var selectedEntry: ChartDataEntry?
    var body: some View {
        //HStack() {
        TabView(selection: $trendStates.weekChartCount) {
            //TODO: 임시 데이터 수
            ForEach(0 ..< trendStates.weekChartCount) { chartIndex in
                VStack(alignment: .leading, spacing: .zero) {
                    AverageCaffeineAmountForWeek(trendStates: trendStates)
                        .padding(TrendViewLayoutValue.Paddings.averageCaffeineAmountPadding)
                    HStack(alignment: .center, spacing: .zero) {
                        Spacer()
                        Circle()
                            .foregroundColor(.customRed)
                            .frame(width: 12, height: 12, alignment: .center)
                            .padding(.trailing, 7)
                        Text("부작용")
                            .font(.caption)
                            .foregroundColor(.secondaryTextGray)
                    }
                    .padding(.trailing, TrendViewLayoutValue.Paddings.chartInsidePadding)
                    TrendChartView(trendStates: trendStates, selectedBarTopCentreLocation: $selectedBarTopCentreLocation, selectedEntry: $selectedEntry)
                }
                .tag(chartIndex)
                .frame(maxWidth: TrendViewLayoutValue.Sizes.cardWidth, alignment: .leading)
                .background(CardBackground())
                .padding(TrendViewLayoutValue.Paddings.chartPadding)
                
            }
            
        }
        .frame(width: TrendViewLayoutValue.Sizes.mainWidth, height: TrendViewLayoutValue.Sizes.chartHeight, alignment: .center)
        .tabViewStyle(.page(indexDisplayMode: .never))
    }
}

struct AverageCaffeineAmountForWeek: View {
    @StateObject var trendStates: TrendStateHolder
    
    func getAverageAmount() -> Int {
        var averageAmount = 0
        var intakeCaffeineIndex = 0
        for entryIndex in 0 ..< 7 {
            averageAmount += trendStates.intakeManager.getDailyIntakeCaffeineAmount(date: trendStates.dateOfRecordsByWeek[trendStates.weekChartCount][entryIndex])
            if trendStates.intakeManager.getDailyIntakeCaffeineAmount(date: trendStates.dateOfRecordsByWeek[trendStates.weekChartCount][entryIndex]) != 0 {
                intakeCaffeineIndex += 1
            }
        }
        return averageAmount / intakeCaffeineIndex
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: .zero) {
            Text("하루 평균 섭취량")
                .font(.subheadline)
                .foregroundColor(.black)
                .padding(.bottom, TrendViewLayoutValue.Paddings.textVerticalPadding)
            HStack(alignment: .firstTextBaseline, spacing: .zero){
                Text("\(getAverageAmount())")
                    .font(.largeTitle)
                    .foregroundColor(.black)
                    .padding(.trailing, TrendViewLayoutValue.Paddings.caffeineRecordAmountUnitPadding)
                Text("mg")
                    .font(.body)
                    .foregroundColor(.secondaryTextGray)
            }
            .padding(.bottom, TrendViewLayoutValue.Paddings.averageCaffeineWeekPadding)
            HStack(spacing:0) {
                Text(Formatter.date.string(from:  trendStates.dateOfRecordsByWeek[trendStates.weekChartCount][0]))
                Text("~")
                Text(Formatter.date.string(from: trendStates.dateOfRecordsByWeek[trendStates.weekChartCount][6]))
            }
            .font(.body)
            .foregroundColor(.secondaryTextGray)
        }
    }
}

struct SideEffectRecordsByDay: View {
    let trendStates = TrendStateHolder()
    let dailySideEffects: [SideEffect]
    let SelectedChartIndex = TrendView().isSelectedChartCell()
    init() {
        dailySideEffects = trendStates.sideEffectManager.getDailyRecords(date: trendStates.dateOfRecordsByWeek[trendStates.weekChartCount][SelectedChartIndex])
    }
    var body: some View {
        VStack(alignment: .leading, spacing: TrendViewLayoutValue.Paddings.sideEffectRecordCellVerticalPadding) {
            ForEach(0 ..< 1) { sideEffectRowIndex in
                HStack(alignment: .center, spacing: TrendViewLayoutValue.Paddings.sideEffectRecordCellHorizontalPadding) {
                    //TODO: 임시 데이터 수
                    ForEach(dailySideEffects, id: \.self) { sideEffectItemIndex in
                        SideEffectRecordItem(sideEffectRecord: sideEffectItemIndex)
                    }
                }
            }
        }
        .frame(width: TrendViewLayoutValue.Sizes.cardWidth, alignment: .leading)
    }
}

struct SideEffectRecordItem: View {
    let trendStates = TrendStateHolder()
    let sideEffectRecord: SideEffect
    
    var body: some View {
        VStack(spacing: .zero) {
            Image(sideEffectRecord.getImageName())
            Text(sideEffectRecord.getSideEffectName())
                .font(.caption)
        }
        .frame(width: TrendViewLayoutValue.Sizes.sideEffectRecordCellFixedWidth)
    }
}

struct CaffeineRecordsByDay: View {
    let trendStates = TrendStateHolder()
    let caffeineWeekRecords: [IntakeRecord]
    let SelectedChartIndex = TrendView().isSelectedChartCell()
    init() {
        caffeineWeekRecords = trendStates.intakeManager.getDailyRecords(date: trendStates.dateOfRecordsByWeek[trendStates.weekChartCount][SelectedChartIndex])
    }
    
    var body: some View {
        LazyVStack(spacing: .zero) {
            //TODO: 임시 데이터 수
            ForEach(trendStates.intakeRecords) { CaffeineRecordCellIndex in
                CaffeineRecordCell(record: CaffeineRecordCellIndex)
            }
        }
        .frame(width: TrendViewLayoutValue.Sizes.cardWidth)
    }
}

struct CaffeineRecordCell: View {
    
    let trendStates = TrendStateHolder()
    let record: IntakeRecord
    
    var body: some View {
        VStack(spacing: .zero) {
            HStack(alignment: .center, spacing: .zero) {
                VStack(alignment: .leading, spacing: .zero) {
                    Text(Formatter.dateWithTime.string(from: record.date))
                        .font(.caption)
                        .foregroundColor(.secondaryTextGray)
                        .padding(.bottom, TrendViewLayoutValue.Paddings.dayRecordPadding)
                    HStack(alignment: .firstTextBaseline, spacing: .zero) {
                        Text(record.beverage.name)
                            .font(.title3)
                            .padding(.trailing, TrendViewLayoutValue.Paddings.textVerticalPadding)
                        Text(record.beverage.franchise.getFranchiseName())
                            .font(.caption)
                            .foregroundColor(.secondaryTextGray)
                    }
                }
                Spacer()
                HStack(alignment: .firstTextBaseline, spacing: .zero) {
                    Text("\(trendStates.intakeManager.getCaffeineAmount(record: record))")
                        .font(.title)
                        .padding(.trailing, TrendViewLayoutValue.Paddings.caffeineRecordAmountUnitPadding)
                    Text("mg")
                        .font(.subheadline)
                        .foregroundColor(.secondaryTextGray)
                }
            }
            .padding(TrendViewLayoutValue.Paddings.caffeineRecordRowVerticalPadding)
            Divider()
            
        }
    }
}

struct CardBackground: View {
    var body: some View {
        RoundedRectangle(cornerRadius: TrendViewLayoutValue.Radius.cardRadius)
            .foregroundColor(.white)
            .shadow(color: .primaryShadowGray, radius: TrendViewLayoutValue.Radius.shadowRadius, x: .zero, y: .zero)
    }
}

struct TrendView_Previews: PreviewProvider {
    var selectedEntry = ChartDataEntry(x: "월", y: 1.0)
    static var previews: some View {
        TrendView()
    }
}

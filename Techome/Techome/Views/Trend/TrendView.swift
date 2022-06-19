//
//  TrendView.swift
//  Techome
//
//  Created by 한택환 on 2022/06/09.
//

//
import SwiftUI


enum DayOfWeek: Int {
    case 일 = 0
    case 월 = 1
    case 화 = 2
    case 수 = 3
    case 목 = 4
    case 금 = 5
    case 토 = 6
}

class TrendStateHolder: ObservableObject {
    
    let intakeRecords = IntakeManager.shared.getAllRecords().sorted { a, b in
        a.date < b.date
    }
    var dateOfRecords: [Date] = []
    var dateOfRecordsByWeek: [[Date]] = [[Date]]()
    
    
    init() {
        print("??")
        getDateOfRecords()
        getDateOfRecordsByWeek()
    }
    
    private func getDayOfWeek(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko")
        dateFormatter.dateFormat = "E"
        let currentDateString: String = dateFormatter.string(from: date)
        return currentDateString
    }
    
    private func getDateOfRecords() {
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
        let firstDateRecord = intakeRecords.first?.date ?? Date()
        print(intakeRecords)
        var tempDates = [Date]()
        let dayOfWeekOfFirstRecord = getDayOfWeekRawValue()
        
        for index in 0 ..< dayOfWeekOfFirstRecord {
            tempDates.insert(Calendar.current.date(byAdding: .day, value: -index, to: firstDateRecord) ?? Date(), at: 0)
        }
        var firstDayOfNextWeek: Date = Date().startOfDay
        for index in dayOfWeekOfFirstRecord ..< 7 {
            tempDates.append(Calendar.current.date(byAdding: .day, value: index - dayOfWeekOfFirstRecord, to: firstDateRecord) ?? Date())
            firstDayOfNextWeek = Calendar.current.date(byAdding: .day, value: index - dayOfWeekOfFirstRecord + 1, to: firstDateRecord)?.startOfDay ?? Date().startOfDay
        }
        
        dateOfRecordsByWeek.append(tempDates)
        tempDates.removeAll()
        
        var addedDate = firstDayOfNextWeek
        
        while addedDate <= Date().startOfDay {
            for index in 0 ..< 7 {
                tempDates.append(Calendar.current.date(byAdding: .day, value: index, to: addedDate) ?? Date())
            }
            dateOfRecordsByWeek.append(tempDates)
            tempDates.removeAll()
            addedDate = Calendar.current.date(byAdding: .day, value: 7, to: addedDate) ?? Date()
        }
        print(dateOfRecordsByWeek)
    }
    
    private func getDayOfWeekRawValue() -> Int {
        let firstDate = intakeRecords.first?.date ?? Date()
        let firstDateDayOfWeekString = getDayOfWeek(date: firstDate)
        let dayOfWeekDict = ["일" : DayOfWeek.일, "월" : DayOfWeek.월, "화" : DayOfWeek.화, "수" : DayOfWeek.수, "목" : DayOfWeek.목, "금" : DayOfWeek.금, "토" : DayOfWeek.토]
        
        let dayOfWeekDictnum: DayOfWeek = dayOfWeekDict[firstDateDayOfWeekString] ?? .일
        
        return dayOfWeekDictnum.rawValue
    }
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

struct ChartsView: View {
    @ObservedObject var trendStates: TrendStateHolder
    let intakeManager = IntakeManager.shared
    let dayOfWeekString = ["일", "월", "화", "수", "목", "금", "토"]
    @State var isSelected: [Bool] = Array(repeating: false, count: 7)
    @State var tabViewIndex: Int = 0
    @State var dayIndex: Int? = nil
    
    var body: some View {
        GeometryReader { geometry in
                VStack(spacing: 0) {
                    TabView(selection: $tabViewIndex) {
                        ForEach(trendStates.dateOfRecordsByWeek.indices, id: \.self) { weekDatasIndex in
                            ZStack(alignment: .bottom) {
                                let lagestNum = getBiggestNum(datas: trendStates.dateOfRecordsByWeek[weekDatasIndex])
                                ForEach(trendStates.dateOfRecordsByWeek[weekDatasIndex].indices, id: \.self) { dayDataIndex in
                                    VStack(spacing: 0) {
                                        Spacer()
                                        let num = CGFloat(intakeManager.getDailyIntakeCaffeineAmount(date: trendStates.dateOfRecordsByWeek[weekDatasIndex][dayDataIndex]))
                                        if num != 0 {
                                            ChartIndicator(caffeineAmount: Int(num))
                                                .opacity(isSelected[dayDataIndex] ? 1.0 : 0.0)
                                            RoundedRectangle(cornerRadius: 3)
                                                .frame(width: geometry.size.width * 0.07,
                                                       height: geometry.size.height * 0.5 * (num / lagestNum))
                                                .foregroundColor(.blue)
                                                .padding(.bottom)
                                                .onTapGesture {
                                                    if isSelected[dayDataIndex] {
                                                        isSelected[dayDataIndex] = false
                                                        dayIndex = nil
                                                    } else {
                                                        isSelected = Array(repeating: false, count: 7)
                                                        isSelected[dayDataIndex] = true
                                                        dayIndex = dayDataIndex
                                                    }
                                                }
                                        }
                                        Text(dayOfWeekString[dayDataIndex])
                                    }
                                    .position(x: geometry.size.width / 8 * CGFloat((dayDataIndex + 1)), y: geometry.size.height * 0.3 )
                                }
                                .tag(weekDatasIndex)
                            }
                        }
                        
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never))
                    .onChange(of: tabViewIndex) { _ in
                        isSelected = Array(repeating: false, count: 7)
                        dayIndex = nil
                    }
                    .onAppear {
                        tabViewIndex = trendStates.dateOfRecordsByWeek.count - 1
                    }
                    if let dayIndex = dayIndex {
                        List {
                            ForEach(intakeManager.getDailyRecords(date: trendStates.dateOfRecordsByWeek[tabViewIndex][dayIndex]), id: \.self) { _ in
                                Text("??")
                            }
                        }
                    }
                    
                }
            }
    }
    
    private func getBiggestNum(datas: [Date]) -> CGFloat {
        var largestNum: CGFloat = 0
        for data in datas {
            let newNum = CGFloat(intakeManager.getDailyIntakeCaffeineAmount(date: data))
            if largestNum < newNum {
                largestNum = newNum
            }
        }
        return largestNum
    }
}

struct ChartIndicator: View {
    let caffeineAmount: Int
    
    var body: some View {
        VStack(spacing: 0) {
            Text("\(Int(caffeineAmount))")
                .font(.title)
                .lineLimit(1)
                .padding(.horizontal, 15)
                .padding(.vertical, 13)
                .background(RoundedRectangle(cornerRadius: 7)
                    .foregroundColor(.chartIndicatorBackgroundGray))
            Rectangle()
                .frame(width: 1, height: 20)
            
        }
    }
}


struct TrendView: View {
    var trendStates = TrendStateHolder()
    
    var body: some View {
        NavigationView {
            VStack(spacing: .zero) {
                
                
                ChartsView(trendStates: trendStates)
                Spacer()
                NavigationLink {
                    TotalListView()
                        .environmentObject(TotalListStateHolder())
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 7)
                            .frame(width: 200, height: 50)
                        Text("전체 리스트 보기")
                            .font(.subheadline)
                            .foregroundColor(.secondaryTextGray)
                    }
                }
            }
        }
    }
}


struct TrendView_Previews: PreviewProvider {
    static var previews: some View {
        TrendView()
    }
}







//import BarChart
//
//
//struct TrendViewLayoutValue {
//
//    struct Paddings {
//        ///TrendView Paddings
//        static let dayRecordPadding: CGFloat = 4
//        static let caffeineRecordRowVerticalPadding: CGFloat = 15
//        static let caffeineRecordRowHorizontalPadding: CGFloat = 20
//        static let chartPadding: CGFloat = 8
//        static let textVerticalPadding: CGFloat = 5
//        static let averageCaffeineWeekPadding: CGFloat = 7
//        static let sideEffectRecordCellHorizontalPadding: CGFloat = 21
//        static let sideEffectRecordCellVerticalPadding: CGFloat = 20
//        static let averageCaffeineAmountPadding: CGFloat = 15
//        static let caffeineRecordAmountUnitPadding: CGFloat = 1
//        static let totalListViewPadding: CGFloat = 20
//        static let chartInsidePadding: CGFloat = 15
//        static let chartIndicatorVertical: CGFloat = 10
//    }
//
//    ///TrendView Sizes
//    struct Sizes {
//        static let mainWidth: CGFloat = UIScreen.main.bounds.width
//        static let mainHeight: CGFloat = UIScreen.main.bounds.height
//        static let cardWidth: CGFloat = UIScreen.main.bounds.width - 30
//        static let chartHeight: CGFloat = cardWidth * 1.26
//        static let sideEffectRecordHeight: CGFloat = cardWidth / 2.4
//        static let sideEffectRecordCellFixedWidth: CGFloat = 46
//        static let chartSelectionIndicatorHeight: CGFloat = 83
//    }
//    ///TrendView Radius
//    struct Radius {
//        static let cardRadius: CGFloat = 7
//        static let shadowRadius: CGFloat = 2
//    }
//}
//
//struct TrendView: View {
//    @StateObject var trendStates: TrendStateHolder = TrendStateHolder()
//    @State private var dailySideEffects: [SideEffect] = []
//    @State private var caffeineWeekRecords: [IntakeRecord] = []
//
//
//    struct selectionCaffeineSideEffectLabelView: View {
//        @Binding var dailySideEffects: [SideEffect]
//        @Binding var caffeineWeekRecords: [IntakeRecord]
//        @StateObject var trendStates: TrendStateHolder
//
//        var body: some View {
//            if trendStates.selectedEntry != nil && trendStates.selectedBarTopCentreLocation != nil {
//                    Group {
//                        SideEffectRecordsByDay(dailySideEffects: $dailySideEffects)
//                        CaffeineRecordsByDay(caffeineWeekRecords: $caffeineWeekRecords)
//                    }
//                    .background(CardBackground())
//                    .padding(.vertical, TrendViewLayoutValue.Paddings.dayRecordPadding)
//                } else {
//                    VStack(spacing: 0){
//                    }
//                }
//        }
//    }
//
//    var body: some View {
//        NavigationView {
//            ZStack {
//                Color.backgroundCream
//                    .edgesIgnoringSafeArea(.all)
//
//                ScrollView {
//                    VStack(spacing: .zero) {
//                        Text("\(trendStates.selectionIdx)")
//                        TrendChart(trendStates: trendStates)
//                        selectionCaffeineSideEffectLabelView( dailySideEffects: $dailySideEffects, caffeineWeekRecords: $caffeineWeekRecords, trendStates: trendStates)
//                        NavigationLink {
//                            TotalListView()
//                                .environmentObject(TotalListStateHolder())
//                        } label: {
//                            Text("전체 리스트 보기")
//                                .font(.subheadline)
//                                .foregroundColor(.secondaryTextGray)
//                                .padding(TrendViewLayoutValue.Paddings.totalListViewPadding)
//                        }
//
//                        Spacer()
//                    }
//                    .navigationTitle("카페인 리포트")
//                }
//            }
//        }
//    }
//}
//class TrendStateHolder: ObservableObject {
//    let intakeManager: IntakeManager = IntakeManager.shared
//    let sideEffectManager: SideEffectManager = SideEffectManager.shared
//    var intakeRecords: [IntakeRecord]
//    var ChartWeekIndex: Int = 0
//    @Published var selectionIdx = 0
//    @Published var selectedBarTopCentreLocation: CGPoint? = nil
//    @Published var selectedEntry: ChartDataEntry? = nil
//    var dateOfRecords: [Date] = [Date]()
//    var dateOfRecordsByWeek = [[Date]]()
//    var weekChartCount: Int = 0
//    var firstDateRecord: Date //= [IntakeRecord]().first?.date ?? Date()
//
//    init() {
//        intakeRecords = intakeManager.getAllRecords()
//        print("0000000000000")
//        print(intakeRecords)
//        firstDateRecord = intakeRecords.first?.date ?? Date()
//
//        getDateOfRecordsByWeek()
//    }
//
//    func isSelectedChartCell() -> Int {
//        for entryIndex in 0 ..< 7 {
//            if selectedEntry?.y == Double(intakeManager.getDailyIntakeCaffeineAmount(date: dateOfRecordsByWeek[selectionIdx][entryIndex])) && selectedEntry?.x == SetEntries.getDayOfWeek(dateOfRecordsByWeek[selectionIdx][entryIndex]) {
//                return entryIndex
//            }
//        }
//        return 0
//    }
//    //TODO: 리팩토링
//    func getDateOfRecords() {
//        intakeRecords = intakeManager.getDailyRecords(date: firstDateRecord)
//        for intakeRecord in intakeRecords {
//            var isSameDate = false
//            for dateOfRecord in dateOfRecords {
//                if Calendar.current.isDate(intakeRecord.date, inSameDayAs: dateOfRecord) {
//                    isSameDate = true
//                    break
//                }
//            }
//            if !isSameDate {
//                dateOfRecords.append(intakeRecord.date)
//            }
//        }
//    }
//    // getDayOfWeek -> DayOfWeekOfFirstRecord
//    func getDateOfRecordsByWeek() {
//        var tempDates = [Date]()
//        let dayOfWeekOfFirstRecord = getDayOfWeek()
//
//        for index in 0 ..< dayOfWeekOfFirstRecord {
//            print("11111111111111111111 \(getDayOfWeek())")
//            print("22222222222222222222 \(firstDateRecord)")
//            tempDates.insert(Calendar.current.date(byAdding: .day, value: -index, to: firstDateRecord) ?? Date(), at: 0)
//        }
//        var firstDayOfNextWeek: Date = Date().startOfDay
//        for index in dayOfWeekOfFirstRecord ..< 7 {
//            tempDates.append(Calendar.current.date(byAdding: .day, value: index - dayOfWeekOfFirstRecord, to: firstDateRecord) ?? Date())
//            firstDayOfNextWeek = Calendar.current.date(byAdding: .day, value: index - dayOfWeekOfFirstRecord + 1, to: firstDateRecord)?.startOfDay ?? Date().startOfDay
//        }
//
//        dateOfRecordsByWeek.append(tempDates)
//        tempDates.removeAll()
//
//        //print("3333333333333333333333 \(firstDayOfNextWeek)")
//
//        var addedDate = firstDayOfNextWeek
//
//        while addedDate <= Date().startOfDay {
//            for index in 0 ..< 7 {
//                tempDates.append(Calendar.current.date(byAdding: .day, value: index, to: addedDate) ?? Date())
//            }
//            dateOfRecordsByWeek.append(tempDates)
//            tempDates.removeAll()
//            addedDate = Calendar.current.date(byAdding: .day, value: 7, to: addedDate) ?? Date()
//        }
//        print("4444444444444444444444444")
//        print(dateOfRecordsByWeek)
//
//        weekChartCount = dateOfRecordsByWeek.count
//    }
//
//    func getDayOfWeek() -> Int {
//        let firstDate = intakeRecords.first?.date ?? Date()
//        let firstDateDayOfWeekString = SetEntries.getDayOfWeek(firstDate)
//        let dayOfWeekDict = ["일" : DayOfWeek.일, "월" : DayOfWeek.월, "화" : DayOfWeek.화, "수" : DayOfWeek.수, "목" : DayOfWeek.목, "금" : DayOfWeek.금, "토" : DayOfWeek.토]
//
//        let dayOfWeekDictnum: DayOfWeek = dayOfWeekDict[firstDateDayOfWeekString] ?? .일
//
//        return dayOfWeekDictnum.rawValue
//    }
//}
//enum DayOfWeek: Int {
//    case 일 = 0
//    case 월 = 1
//    case 화 = 2
//    case 수 = 3
//    case 목 = 4
//    case 금 = 5
//    case 토 = 6
//}
//extension Date {
//    var startOfDay: Date {
//        return Calendar.current.startOfDay(for: self)
//    }
//
//    func localDate() -> Date {
//        let nowUTC = Date()
//        let timeZoneOffset = Double(TimeZone.current.secondsFromGMT(for: nowUTC))
//        guard let localDate = Calendar.current.date(byAdding: .second, value: Int(timeZoneOffset), to: nowUTC) else {return Date()}
//
//        return localDate
//    }
//}
//
//struct TrendChart: View {
//    @StateObject var trendStates: TrendStateHolder
//
//    var body: some View {
//        //HStack() {
//        TabView(selection: $trendStates.selectionIdx) {
//            //TODO: 임시 데이터 수
//            ForEach(0 ..< trendStates.weekChartCount, id: \.self) { chartIndex in
//                VStack(alignment: .leading, spacing: .zero) {
//                    AverageCaffeineAmountForWeek(trendStates: trendStates)
//                        .padding(TrendViewLayoutValue.Paddings.averageCaffeineAmountPadding)
//                    HStack(alignment: .center, spacing: .zero) {
//                        Spacer()
//                        Circle()
//                            .foregroundColor(.customRed)
//                            .frame(width: 12, height: 12, alignment: .center)
//                            .padding(.trailing, 7)
//                        Text("부작용")
//                            .font(.caption)
//                            .foregroundColor(.secondaryTextGray)
//                    }
//                    .padding(.trailing, TrendViewLayoutValue.Paddings.chartInsidePadding)
//                    TrendChartView(trendStates: trendStates)
//                }
//                .tag(chartIndex)
//                .frame(maxWidth: TrendViewLayoutValue.Sizes.cardWidth, alignment: .leading)
//                .background(CardBackground())
//                .padding(TrendViewLayoutValue.Paddings.chartPadding)
//
//            }
//
//        }
//
//        .frame(width: TrendViewLayoutValue.Sizes.mainWidth, height: TrendViewLayoutValue.Sizes.chartHeight, alignment: .center)
//        .tabViewStyle(.page(indexDisplayMode: .never))
//        .onAppear {
//            trendStates.selectionIdx = trendStates.weekChartCount - 1
//        }
//    }
//}
//
//struct AverageCaffeineAmountForWeek: View {
//    @StateObject var trendStates: TrendStateHolder
//
//    func getAverageAmount() -> Int {
////        var averageAmount = 0
////        var intakeCaffeineIndex = 0
////        for entryIndex in 0 ..< 7 {
////            averageAmount += trendStates.intakeManager.getDailyIntakeCaffeineAmount(date: trendStates.dateOfRecordsByWeek[trendStates.weekChartCount][entryIndex])
////            if trendStates.intakeManager.getDailyIntakeCaffeineAmount(date: trendStates.dateOfRecordsByWeek[trendStates.weekChartCount][entryIndex]) != 0 {
////                intakeCaffeineIndex += 1
////            }
////        }
//        return 300
//
//    }
//
//    var body: some View {
//        VStack(alignment: .leading, spacing: .zero) {
//            Text("하루 평균 섭취량")
//                .font(.subheadline)
//                .foregroundColor(.black)
//                .padding(.bottom, TrendViewLayoutValue.Paddings.textVerticalPadding)
//            HStack(alignment: .firstTextBaseline, spacing: .zero){
//                Text("\(getAverageAmount())")
//                    .font(.largeTitle)
//                    .foregroundColor(.black)
//                    .padding(.trailing, TrendViewLayoutValue.Paddings.caffeineRecordAmountUnitPadding)
//                Text("mg")
//                    .font(.body)
//                    .foregroundColor(.secondaryTextGray)
//            }
//            .padding(.bottom, TrendViewLayoutValue.Paddings.averageCaffeineWeekPadding)
//            HStack(spacing:0) {
//                Text(Formatter.date.string(from:  trendStates.dateOfRecordsByWeek[trendStates.selectionIdx][0]))
//                Text("~")
//                Text(Formatter.date.string(from: trendStates.dateOfRecordsByWeek[trendStates.selectionIdx][6]))
//            }
//            .font(.body)
//            .foregroundColor(.secondaryTextGray)
//        }
//    }
//}
//
//struct SideEffectRecordsByDay: View {
//    let trendStates = TrendStateHolder()
//    @Binding var dailySideEffects: [SideEffect]
//    var SelectedChartIndex: Int { trendStates.isSelectedChartCell() }
//
//
//    var body: some View {
//        VStack(alignment: .leading, spacing: TrendViewLayoutValue.Paddings.sideEffectRecordCellVerticalPadding) {
//            ForEach(0 ..< 1) { sideEffectRowIndex in
//                HStack(alignment: .center, spacing: TrendViewLayoutValue.Paddings.sideEffectRecordCellHorizontalPadding) {
//                    //TODO: 임시 데이터 수
//                    ForEach(dailySideEffects, id: \.self) { sideEffectItemIndex in
//                        SideEffectRecordItem(sideEffectRecord: sideEffectItemIndex)
//                    }
//                }
//            }
//        }
//        .frame(width: TrendViewLayoutValue.Sizes.cardWidth, alignment: .leading)
//        .onAppear {
//            dailySideEffects = trendStates.sideEffectManager.getDailyRecords(date: trendStates.dateOfRecordsByWeek[trendStates.selectionIdx][SelectedChartIndex])
//        }
//    }
//}
//
//struct SideEffectRecordItem: View {
//    let trendStates = TrendStateHolder()
//    let sideEffectRecord: SideEffect
//
//    var body: some View {
//        VStack(spacing: .zero) {
//            Image(sideEffectRecord.getImageName())
//            Text(sideEffectRecord.getSideEffectName())
//                .font(.caption)
//        }
//        .frame(width: TrendViewLayoutValue.Sizes.sideEffectRecordCellFixedWidth)
//    }
//}
//
//struct CaffeineRecordsByDay: View {
//    let trendStates = TrendStateHolder()
//    @Binding var caffeineWeekRecords: [IntakeRecord]
//    var SelectedChartIndex: Int { trendStates.isSelectedChartCell() }
//
//
//    var body: some View {
//        LazyVStack(spacing: .zero) {
//            //TODO: 임시 데이터 수
//            ForEach(trendStates.intakeRecords) { CaffeineRecordCellIndex in
//                CaffeineRecordCell(record: CaffeineRecordCellIndex)
//            }
//        }
//        .frame(width: TrendViewLayoutValue.Sizes.cardWidth)
//        .onAppear {
//            caffeineWeekRecords = trendStates.intakeManager.getDailyRecords(date: trendStates.dateOfRecordsByWeek[trendStates.selectionIdx][SelectedChartIndex])
//            print("123123123123123 \(SelectedChartIndex)")
//        }
//    }
//}
//
//struct CaffeineRecordCell: View {
//
//    let trendStates = TrendStateHolder()
//    let record: IntakeRecord
//
//    var body: some View {
//        VStack(spacing: .zero) {
//            HStack(alignment: .center, spacing: .zero) {
//                VStack(alignment: .leading, spacing: .zero) {
//                    Text(Formatter.dateWithTime.string(from: record.date))
//                        .font(.caption)
//                        .foregroundColor(.secondaryTextGray)
//                        .padding(.bottom, TrendViewLayoutValue.Paddings.dayRecordPadding)
//                    HStack(alignment: .firstTextBaseline, spacing: .zero) {
//                        Text(record.beverage.name)
//                            .font(.title3)
//                            .padding(.trailing, TrendViewLayoutValue.Paddings.textVerticalPadding)
//                        Text(record.beverage.franchise.getFranchiseName())
//                            .font(.caption)
//                            .foregroundColor(.secondaryTextGray)
//                    }
//                }
//                Spacer()
//                HStack(alignment: .firstTextBaseline, spacing: .zero) {
//                    Text("\(trendStates.intakeManager.getCaffeineAmount(record: record))")
//                        .font(.title)
//                        .padding(.trailing, TrendViewLayoutValue.Paddings.caffeineRecordAmountUnitPadding)
//                    Text("mg")
//                        .font(.subheadline)
//                        .foregroundColor(.secondaryTextGray)
//                }
//            }
//            .padding(TrendViewLayoutValue.Paddings.caffeineRecordRowVerticalPadding)
//            Divider()
//
//        }
//    }
//}
//
//struct CardBackground: View {
//    var body: some View {
//        RoundedRectangle(cornerRadius: TrendViewLayoutValue.Radius.cardRadius)
//            .foregroundColor(.white)
//            .shadow(color: .primaryShadowGray, radius: TrendViewLayoutValue.Radius.shadowRadius, x: .zero, y: .zero)
//    }
//}
//
//struct TrendView_Previews: PreviewProvider {
//    var selectedEntry = ChartDataEntry(x: "월", y: 1.0)
//    static var previews: some View {
//        TrendView()
//    }
//}

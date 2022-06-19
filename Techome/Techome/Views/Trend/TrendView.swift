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
            tempDates.insert(Calendar.current.date(byAdding: .day, value: -( index + 1), to: firstDateRecord) ?? Date(), at: 0)
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
    let sideEffectManager = SideEffectManager.shared
    let dayOfWeekString = ["일", "월", "화", "수", "목", "금", "토"]
    let columns: [GridItem] = [
        GridItem(.fixed(TotalListLayoutValue.Sizes.sideEffectRecordCellFixedWidth), spacing: TotalListLayoutValue.Paddings.sideEffectRecordCellHorizontalPadding),
        GridItem(.fixed(TotalListLayoutValue.Sizes.sideEffectRecordCellFixedWidth), spacing: TotalListLayoutValue.Paddings.sideEffectRecordCellHorizontalPadding),
        GridItem(.fixed(TotalListLayoutValue.Sizes.sideEffectRecordCellFixedWidth), spacing: TotalListLayoutValue.Paddings.sideEffectRecordCellHorizontalPadding),
        GridItem(.fixed(TotalListLayoutValue.Sizes.sideEffectRecordCellFixedWidth), spacing: TotalListLayoutValue.Paddings.sideEffectRecordCellHorizontalPadding),
        GridItem(.fixed(TotalListLayoutValue.Sizes.sideEffectRecordCellFixedWidth), spacing: TotalListLayoutValue.Paddings.sideEffectRecordCellHorizontalPadding)
    ]
    
    @State var isSelected: [Bool] = Array(repeating: false, count: 7)
    @State var tabViewIndex: Int = 0
    @State var dayIndex: Int? = nil
    var dailySideEffects = [SideEffect]()
    @State var zStackIndex = Array(repeating: Double(0.0), count: 7)
    
    func getDailyAvarageAmount() -> Int {
        var averageAmount = 0
        var count = 0
        for entryIndex in 0 ..< 7 {
            averageAmount += intakeManager.getDailyIntakeCaffeineAmount(date: trendStates.dateOfRecordsByWeek[tabViewIndex][entryIndex])
            if intakeManager.getDailyIntakeCaffeineAmount(date: trendStates.dateOfRecordsByWeek[tabViewIndex][entryIndex]) != 0 {
                count += 1
            }
        }
        return averageAmount
    }
    
    var body: some View {
       
            VStack(spacing: .zero) {
                GeometryReader { geometry in
                    VStack(alignment: .leading, spacing: 0) {
                        
                        Text("하루 평균 섭취량")
                            .font(.subheadline)
                            .foregroundColor(.black)
                            .padding(.bottom, TrendViewLayoutValue.Paddings.textVerticalPadding)
                        HStack(alignment: .firstTextBaseline, spacing: .zero){
                            Text("\(getDailyAvarageAmount())")
                                .font(.largeTitle)
                                .foregroundColor(.black)
                                .padding(.trailing, TrendViewLayoutValue.Paddings.caffeineRecordAmountUnitPadding)
                            Text("mg")
                                .font(.body)
                                .foregroundColor(.secondaryTextGray)
                        }
                        .padding(.bottom, TrendViewLayoutValue.Paddings.averageCaffeineWeekPadding)
                        HStack(spacing:0) {
                            Text(Formatter.date.string(from:  trendStates.dateOfRecordsByWeek[tabViewIndex][0]))
                            Text("~")
                            Text(Formatter.date.string(from: trendStates.dateOfRecordsByWeek[tabViewIndex][6]))
                        }
                        .font(.body)
                        .foregroundColor(.secondaryTextGray)
                        
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
                        
                        TabView(selection: $tabViewIndex) {
                            ForEach(trendStates.dateOfRecordsByWeek.indices, id: \.self) { weekDatasIndex in
                                ZStack(alignment: .bottom) {
                                    let lagestNum = getBiggestNum(datas: trendStates.dateOfRecordsByWeek[weekDatasIndex])
                                    ForEach(trendStates.dateOfRecordsByWeek[weekDatasIndex].indices, id: \.self) { dayDataIndex in
                                        VStack(spacing: 0) {
                                            Spacer()
                                            
                                            let num = CGFloat(intakeManager.getDailyIntakeCaffeineAmount(date: trendStates.dateOfRecordsByWeek[weekDatasIndex][dayDataIndex]))
                                            if num != 0 {
                                                ChartIndicator(caffeineAmount: Int(num),selectedDate: trendStates.dateOfRecordsByWeek[weekDatasIndex][dayDataIndex], dayDataIndex: dayDataIndex)
                                                    .opacity(isSelected[dayDataIndex] ? 1.0 : 0.0)
                                                    .offset(x: dayDataIndex == 0 ? 45 : 0)
                                                    .offset(x: dayDataIndex == 6 ? -45 : 0)
                                                RoundedRectangle(cornerRadius: 3)
                                                    .frame(width: geometry.size.width * 0.07,
                                                           height: geometry.size.height * 0.35 * (num / lagestNum))
                                                    .foregroundColor(SideEffectManager.shared.getDailyRecords(date: trendStates.dateOfRecordsByWeek[weekDatasIndex][dayDataIndex]).count == 0 ? .tertiaryBrown : .customRed)
                                                    .padding(.bottom)
                                                    .onTapGesture {
                                                        if isSelected[dayDataIndex] {
                                                            zStackIndex[dayDataIndex] = 0
                                                            isSelected[dayDataIndex] = false
                                                            dayIndex = nil
                                                            
                                                        } else {
                                                            isSelected = Array(repeating: false, count: 7)
                                                            isSelected[dayDataIndex] = true
                                                            dayIndex = dayDataIndex
                                                            zStackIndex = Array(repeating: 0, count: 7)
                                                            zStackIndex[dayDataIndex] = 1
                                                        }
                                                    }
                                            }
                                            Text(dayOfWeekString[dayDataIndex])
                                        }
                                        .position(x: geometry.size.width / 8 * CGFloat((dayDataIndex + 1)) - 15, y: geometry.size.height * 0.3 )
                                        .zIndex(zStackIndex[dayDataIndex])
                                    }
                                    .tag(weekDatasIndex)
                                }
                            }
                            
                        }
                        .frame(maxWidth: TrendViewLayoutValue.Sizes.cardWidth)
                        .tabViewStyle(.page(indexDisplayMode: .never))
                        .onChange(of: tabViewIndex) { _ in
                            isSelected = Array(repeating: false, count: 7)
                            dayIndex = nil
                        }
                        .onAppear {
                            tabViewIndex = trendStates.dateOfRecordsByWeek.count - 1
                        }
                        
                        
                    }
                    .padding(.all, 15)
                    .background(CardBackground())
                }.frame(maxWidth: TrendViewLayoutValue.Sizes.cardWidth)
                    .frame(height: UIScreen.main.bounds.height / 1.85)
                    .padding(.bottom, 26)
                
                
                if dayIndex != nil {
                    let intakeCaffeineRecords = intakeManager.getDailyRecords(date: trendStates.dateOfRecordsByWeek[tabViewIndex][dayIndex ?? 0])
                    let sideEffectRecords = sideEffectManager.getDailyRecords(date: trendStates.dateOfRecordsByWeek[tabViewIndex][dayIndex ?? 0])
                    HStack(spacing: 0) {
                        Text(Formatter.date.string(from: trendStates.dateOfRecordsByWeek[tabViewIndex][dayIndex ?? 0]))
                            .font(.title3)
                        Spacer()
                    }
                    .padding(.leading, 20)
                    //MARK: 부작용 리스트
                    if sideEffectRecords.count != 0 {
                        LazyVGrid(columns: columns, spacing : TotalListLayoutValue.Paddings.sideEffectRecordCellVerticalPadding) {
                            ForEach(sideEffectRecords, id: \.self) { sideEffect in
                                SideEffectItem(curSideEffect : sideEffect)
                            }
                        }
                        .padding(.vertical, TotalListLayoutValue.Paddings.sideEffectRecordCellVerticalPadding)
                        .padding(.horizontal, TotalListLayoutValue.Paddings.sideEffectRecordRowHorizontalPadding)
                        .background(CardBackground())
                        .frame(width: TrendViewLayoutValue.Sizes.cardWidth)
                    }
                    
                    //MARK: 카페인 리스트
                    LazyVStack(spacing: .zero) {
                        //TODO: 임시 데이터 수
                        ForEach(intakeCaffeineRecords) { CaffeineRecordCellIndex in
                            CaffeineRecordCell(record: CaffeineRecordCellIndex)
                            if (intakeCaffeineRecords.lastIndex(of: CaffeineRecordCellIndex) != intakeCaffeineRecords.count-1) {
                                Divider()
                            }
                            
                        }
                    }
                    .frame(width: TrendViewLayoutValue.Sizes.cardWidth)
                    .padding(.bottom, TrendViewLayoutValue.Paddings.dayRecordPadding)
                    .background(CardBackground())
                    .padding(.top,  TrendViewLayoutValue.Paddings.chartPadding)
                    
                    
                }
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
            .padding(.all, 10)
        }
    }
    
    struct CaffeineRecordCell: View {
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
                        Text("\(IntakeManager.shared.getCaffeineAmount(record: record))")
                            .font(.title)
                            .padding(.trailing, TrendViewLayoutValue.Paddings.caffeineRecordAmountUnitPadding)
                        Text("mg")
                            .font(.subheadline)
                            .foregroundColor(.secondaryTextGray)
                    }
                }
                .padding(TrendViewLayoutValue.Paddings.caffeineRecordRowVerticalPadding)
                
                
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
    let selectedDate: Date
    let dayDataIndex: Int
    
    func getDay(_ today:Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY.MM.dd"
        let currentDateString: String = dateFormatter.string(from: today)
        return currentDateString
    }
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 0) {
                Text("총")
                    .font(.footnote)
                Text("\(Int(caffeineAmount))mg")
                    .font(.title)
                    .lineLimit(1)
                Text(getDay(selectedDate))
                    .font(.footnote)
            }
            .padding(.horizontal, 15)
            .padding(.vertical, 13)
            .background(RoundedRectangle(cornerRadius: 7)
                .foregroundColor(.chartIndicatorBackgroundGray))
            Rectangle()
                .frame(width: 2, height: 10)
                .foregroundColor(.chartIndicatorBackgroundGray)
                .offset(x: dayDataIndex == 0 ? -45 : 0)
                .offset(x: dayDataIndex == 6 ? 45 : 0)
        }
        
    }
}


struct TrendView: View {
    var trendStates = TrendStateHolder()
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.backgroundCream
                    .edgesIgnoringSafeArea(.all)
                ScrollView(showsIndicators: false) {
                VStack(spacing: .zero) {
                    
                    
                    ChartsView(trendStates: trendStates)
                    NavigationLink {
                        TotalListView()
                            .environmentObject(TotalListStateHolder())
                    } label: {
                        Text("전체 리스트 보기")
                            .font(.subheadline)
                            .foregroundColor(.secondaryTextGray)
                            .padding(TrendViewLayoutValue.Paddings.totalListViewPadding)
                    }
                }
                .navigationTitle("카페인 리포트")
            }
        }
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
    static var previews: some View {
        TrendView()
    }
}

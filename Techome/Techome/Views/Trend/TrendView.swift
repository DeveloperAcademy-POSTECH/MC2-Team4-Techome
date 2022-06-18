//
//  TrendView.swift
//  Techome
//
//  Created by 한택환 on 2022/06/09.
//

//
import SwiftUI


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
    @EnvironmentObject var trendStates: TrendStateHolder
    
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.backgroundCream
                .edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    VStack(spacing: .zero) {
                        TrendChart()
//                        TrendChartView().selectionCaffeineSideEffectLabelView()
                        
                        NavigationLink {
                            TotalListView()
                                .environmentObject(Datas())
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

struct TrendChart: View {
    //@EnvironmentObject var trendStates: TrendStateHolder
    @State var index = 0
    var body: some View {
        //HStack() {
        TabView(selection: $index) {
                //TODO: 임시 데이터 수
                ForEach(0 ..< 3) { chartIndex in
                    VStack(alignment: .leading, spacing: .zero) {
                        AverageCaffeineAmountForWeek()
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
                        TrendChartView(index: $index)
                    }
                    .tag(index)
                    .frame(maxWidth: TrendViewLayoutValue.Sizes.cardWidth, alignment: .leading)
                    .background(CardBackground())
                    .padding(TrendViewLayoutValue.Paddings.chartPadding)
                    
                }
                
            }
            .frame(width: TrendViewLayoutValue.Sizes.mainWidth, height: TrendViewLayoutValue.Sizes.chartHeight, alignment: .center)
            .tabViewStyle(.page(indexDisplayMode: .never))
            //.transformEffect(CGAffineTransform(scaleX: -1, y: 1))
        //}
        //.frame(height: TrendViewLayoutValue.Sizes.chartHeight)
    }
}

struct AverageCaffeineAmountForWeek: View {
    var body: some View {
        VStack(alignment: .leading, spacing: .zero) {
            Text("하루 평균 섭취량")
                .font(.subheadline)
                .foregroundColor(.black)
                .padding(.bottom, TrendViewLayoutValue.Paddings.textVerticalPadding)
            HStack(alignment: .firstTextBaseline, spacing: .zero){
                Text("360")
                    .font(.largeTitle)
                    .foregroundColor(.black)
                    .padding(.trailing, TrendViewLayoutValue.Paddings.caffeineRecordAmountUnitPadding)
                Text("mg")
                    .font(.body)
                    .foregroundColor(.secondaryTextGray)
            }
            .padding(.bottom, TrendViewLayoutValue.Paddings.averageCaffeineWeekPadding)
            Text("2022.06.03~2022.06.09")
                .font(.body)
                .foregroundColor(.secondaryTextGray)
        }
    }
}

struct SideEffectRecordsByDay: View {
    let trendStates = TrendStateHolder()
    let dailySideEffects: [SideEffect]
    init() {
        dailySideEffects = trendStates.sideEffectManager.getDailyRecords(date: Date.now)
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
        .padding(.vertical, TrendViewLayoutValue.Paddings.sideEffectRecordCellVerticalPadding)
        .padding(.horizontal, TrendViewLayoutValue.Paddings.sideEffectRecordCellHorizontalPadding)
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
                    Text("\(record.date)")
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
    static var previews: some View {
        TrendView()
    }
}

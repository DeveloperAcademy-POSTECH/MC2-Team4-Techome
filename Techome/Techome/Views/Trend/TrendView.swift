//
//  TrendView.swift
//  Techome
//
//  Created by 한택환 on 2022/06/09.
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
    var body: some View {
        NavigationView {
            ZStack {
                Color.backgroundCream
                .edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    VStack(spacing: .zero) {
                        TrendChart()
                        Group {
                            SideEffectRecordsByDay()
                            CaffeineRecordsByDay()
                        }
                        .background(CardBackground())
                        .padding(.vertical, TrendViewLayoutValue.Paddings.dayRecordPadding)
                        
                        NavigationLink {
                            
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
    var body: some View {
        LazyHStack() {
            TabView {
                //TODO: 임시 데이터 수
                ForEach(0 ..< 5) { chartIndex in
                    VStack(alignment: .leading, spacing: .zero) {
                        AverageCaffeineAmountForWeek()
                            .padding(TrendViewLayoutValue.Paddings.averageCaffeineAmountPadding)
                        TrendChartView()
                        Spacer()
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
        .frame(height: TrendViewLayoutValue.Sizes.chartHeight)
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
    var body: some View {
        VStack(alignment: .center, spacing: TrendViewLayoutValue.Paddings.sideEffectRecordCellVerticalPadding) {
            ForEach(0..<2) { sideEffectRowIndex in
                HStack(alignment: .center, spacing: TrendViewLayoutValue.Paddings.sideEffectRecordCellHorizontalPadding) {
                    //TODO: 임시 데이터 수
                    ForEach(0..<5) { sideEffectItemIndex in
                        SideEffectRecordItem()
                    }
                }
            }
        }
        .padding(.vertical, TrendViewLayoutValue.Paddings.sideEffectRecordCellVerticalPadding)
        .frame(width: TrendViewLayoutValue.Sizes.cardWidth)
    }
}

struct SideEffectRecordItem: View {
    var body: some View {
        VStack(spacing: .zero) {
            Image("esophagitis")
            Text("식도염")
                .font(.caption)
        }
        .frame(width: TrendViewLayoutValue.Sizes.sideEffectRecordCellFixedWidth)
    }
}

struct CaffeineRecordsByDay: View {
    var body: some View {
        LazyVStack(spacing: .zero) {
            //TODO: 임시 데이터 수
            ForEach(0 ..< 10) { CaffeineRecordCellIndex in
                CaffeineRecordCell()
            }
        }
        .frame(width: TrendViewLayoutValue.Sizes.cardWidth)
        
    }
}

struct CaffeineRecordCell: View {
    var body: some View {
        VStack(spacing: .zero) {
            HStack(alignment: .center, spacing: .zero) {
                VStack(alignment: .leading, spacing: .zero) {
                    Text("09:30")
                        .font(.caption)
                        .foregroundColor(.secondaryTextGray)
                        .padding(.bottom, TrendViewLayoutValue.Paddings.dayRecordPadding)
                    HStack(alignment: .firstTextBaseline, spacing: .zero) {
                        Text("아메리카노")
                            .font(.title3)
                            .padding(.trailing, TrendViewLayoutValue.Paddings.textVerticalPadding)
                        Text("스타벅스/Tall")
                            .font(.caption)
                            .foregroundColor(.secondaryTextGray)
                    }
                }
                Spacer()
                HStack(alignment: .firstTextBaseline, spacing: .zero) {
                    Text("150")
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

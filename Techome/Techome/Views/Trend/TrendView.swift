//
//  TrendView.swift
//  Techome
//
//  Created by 한택환 on 2022/06/09.
//

import SwiftUI

struct TrendLayout {
    
    struct Paddings {
        //TrendView Paddings
        static let dayRecordPadding: CGFloat = 8
        static let caffeineRecordRowVerticalPadding: CGFloat = 15
        static let caffeineRecordRowHorizontalPadding: CGFloat = 20
        static let chartPadding: CGFloat = 8
        static let textVerticalPadding: CGFloat = 5
        static let averageCaffeineWeekPadding: CGFloat = 7
        static let sideEffectRecordCellHorizontalPadding: CGFloat = 21
        static let averageCaffeineAmountPadding: CGFloat = 15
        static let caffeineRecordAmountUnitPadding: CGFloat = 1
        static let TotalListViewPadding: CGFloat = 20
    }
    
    //TrendView Sizes
    struct Sizes {
        static let mainWidth: CGFloat = UIScreen.main.bounds.width
        static let mainHeight: CGFloat = UIScreen.main.bounds.height
        static let cardWidth: CGFloat = UIScreen.main.bounds.width - 30
        static let chartHeight: CGFloat = cardWidth * 1.26
        static let sideEffectRecordHeight: CGFloat = cardWidth / 2.4
        static let sideEffectRecordCellFrame: CGFloat = 46
    }
    
    //TrendView Radius
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
                        .padding(.vertical, TrendLayout.Paddings.dayRecordPadding)
                        
                        NavigationLink {
                            
                        } label: {
                            Text("전체 리스트 보기")
                                .font(.subheadline)
                                .foregroundColor(.secondaryTextGray)
                                .padding(TrendLayout.Paddings.TotalListViewPadding)
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
                            .padding(TrendLayout.Paddings.averageCaffeineAmountPadding)
                        
                        Spacer()
                    }
                    .tag(chartIndex)
                    .frame(maxWidth: TrendLayout.Sizes.cardWidth, alignment: .leading)
                    .background(CardBackground())
                    .padding(TrendLayout.Paddings.chartPadding)
                    
                }
            }
            .frame(width: TrendLayout.Sizes.mainWidth, height: TrendLayout.Sizes.chartHeight, alignment: .center)
            .tabViewStyle(.page(indexDisplayMode: .never))
        }
        .frame(height: TrendLayout.Sizes.chartHeight)
    }
}

struct AverageCaffeineAmountForWeek: View {
    var body: some View {
        VStack(alignment: .leading, spacing: .zero) {
            Text("하루 평균 섭취량")
                .font(.subheadline)
                .foregroundColor(.black)
                .padding(.bottom, TrendLayout.Paddings.textVerticalPadding)
            HStack(alignment: .firstTextBaseline, spacing: .zero){
                Text("360")
                    .font(.largeTitle)
                    .foregroundColor(.black)
                    .padding(.trailing, TrendLayout.Paddings.caffeineRecordAmountUnitPadding)
                Text("mg")
                    .font(.body)
                    .foregroundColor(.secondaryTextGray)
            }
            .padding(.bottom, TrendLayout.Paddings.averageCaffeineWeekPadding)
            Text("2022.06.03~2022.06.09")
                .font(.body)
                .foregroundColor(.secondaryTextGray)
        }
    }
}

struct SideEffectRecordsByDay: View {
    let sideEffectRecordRow = [
        GridItem(.flexible(), spacing: .zero, alignment: .center),
        GridItem(.flexible(), spacing: .zero, alignment: .center)
    ]
    var body: some View {
        LazyHGrid(rows: sideEffectRecordRow, spacing: TrendLayout.Paddings.sideEffectRecordCellHorizontalPadding) {
            //TODO: 임시 데이터 수
            ForEach(0 ..< 10) { SideEffectItemIndex in
                SideEffectRecordItem()
            }
        }
        .frame(width: TrendLayout.Sizes.cardWidth, height: TrendLayout.Sizes.sideEffectRecordHeight)
    }
}

struct SideEffectRecordItem: View {
    var body: some View {
        VStack(spacing: .zero) {
            Image("esophagitis")
            Text("식도염")
                .font(.caption)
        }
        .frame(width: TrendLayout.Sizes.sideEffectRecordCellFrame)
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
        .frame(width: TrendLayout.Sizes.cardWidth)
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
                        .padding(.bottom, TrendLayout.Paddings.dayRecordPadding)
                    HStack(alignment: .firstTextBaseline, spacing: .zero) {
                        Text("아메리카노")
                            .font(.title3)
                            .padding(.trailing, TrendLayout.Paddings.textVerticalPadding)
                        Text("스타벅스/Tall")
                            .font(.caption)
                            .foregroundColor(.secondaryTextGray)
                    }
                }
                Spacer()
                HStack(alignment: .firstTextBaseline, spacing: .zero) {
                    Text("150")
                        .font(.title)
                        .padding(.trailing, TrendLayout.Paddings.caffeineRecordAmountUnitPadding)
                    Text("mg")
                        .font(.subheadline)
                        .foregroundColor(.secondaryTextGray)
                }
            }
            .padding(TrendLayout.Paddings.caffeineRecordRowVerticalPadding)
            Divider()
            
        }
    }
}

struct CardBackground: View {
    var body: some View {
        RoundedRectangle(cornerRadius: TrendLayout.Radius.cardRadius)
            .foregroundColor(.white)
            .shadow(color: .primaryShadowGray, radius: TrendLayout.Radius.shadowRadius, x: 0, y: 0)
    }
}

struct TrendView_Previews: PreviewProvider {
    static var previews: some View {
        TrendView()
    }
}

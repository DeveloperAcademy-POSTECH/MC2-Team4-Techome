//
//  TotalListView.swift
//  Techome
//
//  Created by Kimhwiwon on 2022/06/10.
//

import SwiftUI

//TotalListLayout으로 수정 예정
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

// 전체 리스트
struct TotalListView: View {
    var body: some View {
        
        ScrollView(){
        
            LazyVStack(spacing: 23){
                ForEach(1..<10) { _ in
                    TotalRecordsByDay(curDate: "2022.06.03")
                }
                
                
            }
            .padding(.horizontal, 15) //전체 스크린 좌우 padding 15
        }
        .background(Color.backgroundCream)
            
    }
}

//날짜별 카페인 + 부작용 데이터 : 날짜별로 스트레스 + 부작용 데이터 받아와서 뷰 만들기
//(추후) 카페인 데이터인지 부작용 데이터인지에 따라 맞는 리스트 보여주도록 구현, 마지막 리스트 다음에는 divider 없도록
struct TotalRecordsByDay: View {
    let curDate : String
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0){
            
            Text(curDate)
                .font(.title3)
                .fontWeight(.semibold)
                .padding(.bottom, 6)
        
            VStack(spacing: 0){
            
                SideEffectRecordRow()
                Divider()
                    .padding(.horizontal, 15.0)
                CaffeineRecordCellList()
                    .padding(.horizontal, 20.0)
            }
            .padding(.vertical, 3)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 7))
            .shadow(color: Color.primaryShadowGray, radius: 7, x: 0, y: 0)
            
        }
    }
    
}



//부작용 데이터

//부작용 시간 + 부작용 정보
struct SideEffectRecordRow: View {
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            
            HStack(spacing: 0){
            
                Text("09:30")
                    .font(.caption)
                    .foregroundColor(.secondaryTextGray)
                Image(systemName: "exclamationmark.circle")
                    .resizable()
                    .frame(width: 15, height: 15)
                    .foregroundColor(Color.customRed)
                    .padding(.leading, 5)
            }
            .padding(.leading, 20)
            
            SideEffectRecordsByDayList()
            
        }
        .padding(.top, 15)
    }
    
}

//============================================================================
//trend에서 사용하는 컴포넌트 공유 예정


//trend 의 sideEffectRecordsByDay 와 동일
//부작용 데이터
struct SideEffectRecordsByDayList: View {
    let sideEffectRecordRow = [
        GridItem(.flexible(), spacing: 0, alignment: .center),
        GridItem(.flexible(), spacing: 0, alignment: .center)
    ]
    var body: some View {
        LazyHGrid(rows: sideEffectRecordRow, spacing: TrendLayout.Paddings.sideEffectRecordCellHorizontalPadding) {
            //TODO: 임시 데이터 수
            ForEach(0 ..< 10) { SideEffectItemIndex in
                SideEffectRecordItemList()
            }
        }
        .frame(width: TrendLayout.Sizes.cardWidth, height: TrendLayout.Sizes.sideEffectRecordHeight)
    }
}

//trend 의 SideEffectRecordItem 과 동일
struct SideEffectRecordItemList: View {
    var body: some View {
        VStack(spacing: 0) {
            Image("esophagitis")
            Text("식도염")
                .font(.caption)
        }
        .frame(width: TrendLayout.Sizes.sideEffectRecordCellFrame)
    }
}



//trend 의 CaffeineRecordCell 에 padding (.vertical)로 제한하는 코드 추가, 이외 동일
//카페인 데이터
struct CaffeineRecordCellList: View {
    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .center, spacing: 0) {
                VStack(alignment: .leading, spacing: 0) {
                    Text("09:30")
                        .font(.caption)
                        .foregroundColor(.secondaryTextGray)
                        .padding(.bottom, TrendLayout.Paddings.dayRecordPadding)
                    HStack(alignment: .firstTextBaseline, spacing: 0) {
                        Text("아메리카노")
                            .font(.title3)
                            .padding(.trailing, TrendLayout.Paddings.textVerticalPadding)
                        Text("스타벅스/Tall")
                            .font(.caption)
                            .foregroundColor(.secondaryTextGray)
                    }
                }
                Spacer()
                HStack(alignment: .firstTextBaseline, spacing: 0) {
                    Text("150")
                        .font(.title)
                        .padding(.trailing, TrendLayout.Paddings.caffeineRecordAmountUnitPadding)
                    Text("mg")
                        .font(.subheadline)
                        .foregroundColor(.secondaryTextGray)
                }
            }
            .padding(.vertical, TrendLayout.Paddings.caffeineRecordRowVerticalPadding)
            Divider()
            
        }
    }
}



struct TotalListView_Previews: PreviewProvider {
    static var previews: some View {
        TotalListView()
    }
}

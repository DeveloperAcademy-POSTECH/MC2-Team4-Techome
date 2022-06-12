//
//  TotalListView.swift
//  Techome
//
//  Created by Kimhwiwon on 2022/06/10.
//

import SwiftUI


struct TotalListLayout {
    
    struct Paddings {
        
        static let dayRecordPadding: CGFloat = 4
        static let caffeineRecordRowVerticalPadding: CGFloat = 15
        static let caffeineRecordRowHorizontalPadding: CGFloat = 20
        static let textVerticalPadding: CGFloat = 5
        static let sideEffectRecordCellHorizontalPadding: CGFloat = 21
        static let sideEffectRecordCellVerticalPadding: CGFloat = 20
        static let caffeineRecordAmountUnitPadding: CGFloat = 1
        static let TotalListViewPadding: CGFloat = 20
        
    }
    
    struct Sizes {
        static let mainWidth: CGFloat = UIScreen.main.bounds.width
        static let mainHeight: CGFloat = UIScreen.main.bounds.height
        static let cardWidth: CGFloat = UIScreen.main.bounds.width - 30
        static let sideEffectRecordCellFixedWidth: CGFloat = 46
    }
    
    
}

//카페인 + 부작용 리스트 병합에 사용
struct tmpDataTotalList : Hashable {
    var dataType: String
    var dataIdx: Int
}

//카페인 + 부작용 리스트 병합 결과
//(추후 구현) datatype과 idx 활용해 리스트에 넣을 알맞은 데이터 찾기
private var tmpDataTotalListArr : [tmpDataTotalList] = [
    tmpDataTotalList(dataType: "drink", dataIdx: 1),
    tmpDataTotalList(dataType: "sideEffect", dataIdx: 1),
    tmpDataTotalList(dataType: "drink", dataIdx: 2)
]

// 전체 리스트
struct TotalListView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        ScrollView(){
        
            LazyVStack(spacing: 23){
                ForEach(1..<10) { _ in
                    TotalRecordsByDay(curDate: "2022.06.03")
                }
                
                
            }
            .padding(.horizontal, 15) //전체 스크린 좌우 padding 15
            .padding(.top, 23) //navigation bar와 간격
        }
        .background(Color.backgroundCream)
        .navigationTitle(Text("전체 리스트").font(.caption))
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar{
            ToolbarItem(placement: .navigationBarLeading){
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: "chevron.left")
                                .font(.headline)
                                .foregroundColor(.primaryBrown)
                        }
                }
        }
    }
}

//날짜별 카페인 + 부작용 데이터 : 날짜별로 스트레스 + 부작용 데이터 받아와서 뷰 만들기
//(추후) 카페인 데이터인지 부작용 데이터인지에 따라 맞는 리스트 보여주도록 구현, 마지막 리스트 다음에는 divider 없도록
struct TotalRecordsByDay: View {
    let curDate : String
    let dataCount = tmpDataTotalListArr.count
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0){
            
            Text(curDate)
                .font(.title3)
                .fontWeight(.semibold)
                .padding(.bottom, 6)
        
            VStack(spacing: 0){
                
                ForEach(Array(tmpDataTotalListArr.enumerated()), id: \.element) { idx, element in
                    if (element.dataType == "drink"){
                        CaffeineRecordCellList()
                            .padding(.horizontal, TotalListLayout.Paddings.caffeineRecordRowHorizontalPadding)
                    }
                    else if (element.dataType == "sideEffect"){
                        SideEffectRecordRow()
                    }
                    else {
                        
                    }
                    
                    //마지막 데이터 다음 divider 없애기
                    if (idx != tmpDataTotalListArr.count - 1) {
                        Divider()
                            .padding(.horizontal, 15.0)
                    }
                    
                }

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
                    .foregroundColor(.customRed)
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
    var body: some View {
        VStack(alignment: .center, spacing: TotalListLayout.Paddings.sideEffectRecordCellVerticalPadding) {
            ForEach(0..<2) { sideEffectRowIndex in
                HStack(alignment: .center, spacing: TotalListLayout.Paddings.sideEffectRecordCellHorizontalPadding) {
                    //TODO: 임시 데이터 수
                    ForEach(0..<5) { sideEffectItemIndex in
                        SideEffectRecordItemList()
                    }
                }
            }
        }
        .padding(.vertical, TotalListLayout.Paddings.sideEffectRecordCellVerticalPadding)
        .frame(width: TotalListLayout.Sizes.cardWidth)
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
        .frame(width: TotalListLayout.Sizes.sideEffectRecordCellFixedWidth)
    }
}



//trend 의 CaffeineRecordCell 에 padding (.vertical)로 제한하는 코드 추가 & Divider 삭제, 이외 동일
//카페인 데이터
struct CaffeineRecordCellList: View {
    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .center, spacing: 0) {
                VStack(alignment: .leading, spacing: 0) {
                    Text("09:30")
                        .font(.caption)
                        .foregroundColor(.secondaryTextGray)
                        .padding(.bottom, TotalListLayout.Paddings.dayRecordPadding)
                    HStack(alignment: .firstTextBaseline, spacing: 0) {
                        Text("아메리카노")
                            .font(.title3)
                            .padding(.trailing, TotalListLayout.Paddings.textVerticalPadding)
                        Text("스타벅스/Tall")
                            .font(.caption)
                            .foregroundColor(.secondaryTextGray)
                    }
                }
                Spacer()
                HStack(alignment: .firstTextBaseline, spacing: 0) {
                    Text("150")
                        .font(.title)
                        .padding(.trailing, TotalListLayout.Paddings.caffeineRecordAmountUnitPadding)
                    Text("mg")
                        .font(.subheadline)
                        .foregroundColor(.secondaryTextGray)
                }
            }
            .padding(.vertical, TotalListLayout.Paddings.caffeineRecordRowVerticalPadding)
//            Divider()
            
        }
    }
}



struct TotalListView_Previews: PreviewProvider {
    static var previews: some View {
        
        TotalListView()
        
        NavigationView {
            NavigationLink("to total list") {
                TotalListView()
            }
        }
    }
}

//
//  TotalListView.swift
//  Techome
//
//  Created by Kimhwiwon on 2022/06/10.
//

import SwiftUI

struct TotalListLayoutValue {
    
    struct Paddings {
        static let dayRecordPadding: CGFloat = 4
        static let caffeineRecordRowVerticalPadding: CGFloat = 15
        static let caffeineRecordRowHorizontalPadding: CGFloat = 20
        static let textVerticalPadding: CGFloat = 5
        static let sideEffectRecordRowVerticalPadding: CGFloat = 15
        static let sideEffectRecordRowHorizontalPadding: CGFloat = 20
        static let sideEffectRecordCellHorizontalPadding: CGFloat = 21
        static let sideEffectRecordCellVerticalPadding: CGFloat = 20
        static let caffeineRecordAmountUnitPadding: CGFloat = 1
        static let fullViewHorizontalPadding: CGFloat = 15
        static let fullViewVerticalPadding: CGFloat = 23
        static let dateVerticalPadding: CGFloat = 6
        static let dividerHorizontalPadding: CGFloat = 15
    }
    
    struct Sizes {
        static let cardWidth: CGFloat = UIScreen.main.bounds.width - 30
        static let sideEffectRecordCellFixedWidth: CGFloat = 46
        static let deleteButtonWidth: CGFloat = 74
    }
    
    struct Spacings {
        static let sectionByDateSpading: CGFloat = 23
    }
}

// 전체 리스트
struct TotalListView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var totalData = Datas()
    
    var body: some View {
        ScrollView {
            LazyVStack (spacing: TotalListLayoutValue.Spacings.sectionByDateSpading){
                ForEach(totalData.datesArr, id: \.self) { curDate in
                    TotalListByDate(totalData: totalData, curDate: curDate)
                }
            }
            .padding(.horizontal, TotalListLayoutValue.Paddings.fullViewHorizontalPadding)
            .padding(.top, TotalListLayoutValue.Paddings.fullViewVerticalPadding) //navigation bar와 간격
        }
        .background(Color.backgroundCream)
        .navigationTitle(Text("전체 리스트"))
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: "chevron.left")
                                .font(.headline)
                                .foregroundColor(.primaryBrown)
                        }
            }
        }
        .onAppear{
            print("새로운 화면")
            self.totalData.loadData()
            
        }
    }
}


//날짜별 카페인 + 부작용 데이터
//TODO: 날짜별로 스트레스 + 부작용 데이터 받아와서 뷰 만들기
//버튼 구현 reference
//https://www.youtube.com/watch?v=jXVQDmeNb8A
//https://stackoverflow.com/questions/67238383/how-to-swipe-to-delete-in-swiftui-with-only-a-foreach-and-not-a-list
struct TotalListByDate: View {
    
    @ObservedObject var totalData : Datas
    var curDate : String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(curDate)
                .font(.title3)
                .fontWeight(.semibold)
                .padding(.bottom, TotalListLayoutValue.Paddings.dateVerticalPadding)
            
            //curDate에 발생한 카페인과 부작용 정보 보여주기
            VStack(spacing: 0) {
                ForEach(Array(totalData.dataSortedByDate[curDate]!.enumerated()), id: \.element) { index, cell in
                    ZStack{
                        //삭제 버튼
                        deleteButton()
                            .onTapGesture{
                                totalData.deleteData(curCell : cell, curDate : curDate, index : index)
                            }
                        
                        //데이터 표시
//                        Cell(curCell : cell).environmentObject(totalData)
                        Group{
                            switch cell.dataType {
                            case "intake" :
                                CaffeineCell(totalData: totalData, cellData: totalData.sourceData.intakes[cell.dataIndex])
                            case "sideEffect" :
                                SideEffectCell(cellData: totalData.sourceData.sideEffects[cell.dataIndex])
                            default :
                                EmptyView()
                            }
                        }
                        .background(Color.white)
                        .offset(x: totalData.offsetsArr[curDate]?[index] ?? .zero)
                        .gesture(
                            DragGesture()
                                .onChanged { gesture in
                                    gestureChanged(value: gesture, curDate: curDate, index: index)
                                }
                                .onEnded { _ in
                                    gestureEnd(curDate: curDate, index: index)
                                }
                            )
                    }
                    
                    //마지막 cell 다음의 divider는 그리지 않음
                    if (index != (totalData.dataSortedByDate[curDate]?.count ?? 0) - 1) {
                        Divider()
                            .padding(.horizontal, TotalListLayoutValue.Paddings.dividerHorizontalPadding)
                            .background(Color.white)
                    }
                }
            }
            .padding(.vertical, 3)
            .clipShape(RoundedRectangle(cornerRadius: 7))
            .shadow(color: Color.primaryShadowGray, radius: 7, x: 0, y: 0)
        }
    }
    
    //제스쳐 함수
    //onChanged : 제스쳐 움직임을 cell에 실시간으로 반영
    //오른쪽 방향으로 움직일 경우 cell 위치 원상복귀
    func gestureChanged(value: DragGesture.Value, curDate: String, index: Int) {
        totalData.resetOffsets()
        guard totalData.offsetsArr[curDate] != nil else {
            return
        }
        totalData.offsetsArr[curDate]?[index] = value.translation.width
        if totalData.offsetsArr[curDate]?[index] ?? .zero > TotalListLayoutValue.Sizes.deleteButtonWidth {
            totalData.offsetsArr[curDate]?[index] = .zero
        }
    }
    //onEnd : 제스쳐가 끝나는 시점 체크
    //왼쪽으로 74 이상 움직였을 경우 cell이 74만큼 왼쪽으로 이동된 상태 유지, 왼쪽으로 74 이상 움직이지 않았을 경우 cell 위치 원상복귀
    func gestureEnd(curDate: String, index: Int){
        guard totalData.offsetsArr[curDate] != nil else {
            return
        }
        if totalData.offsetsArr[curDate]?[index] ?? .zero < -TotalListLayoutValue.Sizes.deleteButtonWidth {
            totalData.offsetsArr[curDate]?[index] = -TotalListLayoutValue.Sizes.deleteButtonWidth
        }
        else if totalData.offsetsArr[curDate]?[index] ?? .zero > -TotalListLayoutValue.Sizes.deleteButtonWidth {
            totalData.offsetsArr[curDate]?[index] = .zero
        }
    }
}

//버튼 컴포넌트
struct deleteButton: View {
    
    var body: some View {
        ZStack{
            HStack(spacing: 0){
                Color.white
                Color.customRed
            }
            
            Text("삭제")
                .font(.body)
                .foregroundColor(Color.white)
                .padding(.leading, TotalListLayoutValue.Sizes.cardWidth - TotalListLayoutValue.Sizes.deleteButtonWidth)
        }
    }
}

//데이터 컴포넌트 (하나의 row) : 데이터 타입(카페인, 부작용)에 따라 맞는 컴포넌트 보여줌
struct Cell: View {
    @EnvironmentObject var totalData : Datas
    
    var curCell : TotalDataCell
    
    var body : some View {
        Group{
            switch curCell.dataType {
            case "intake" :
                CaffeineCell(totalData: totalData, cellData: totalData.sourceData.intakes[curCell.dataIndex])
            case "sideEffect" :
                SideEffectCell(cellData: totalData.sourceData.sideEffects[curCell.dataIndex])
            default :
                EmptyView()
            }
        }
        .background(Color.white)
    }
}

//부작용 데이터 컴포넌트 : 부작용 시간 + 부작용 정보
struct SideEffectCell: View {
    var cellData: SideEffectRecord
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 0) {
                Text(dateToTime(dateInfo: cellData.date))
                    .font(.caption)
                    .foregroundColor(.secondaryTextGray)
                Image(systemName: "exclamationmark.circle")
                    .resizable()
                    .frame(width: 15, height: 15)
                    .foregroundColor(.customRed)
                    .padding(.leading, 5)
            }
            .padding(.horizontal, TotalListLayoutValue.Paddings.sideEffectRecordRowHorizontalPadding)
            SideEffectsInCell(sideEffectsArr : cellData.sideEffects)
        }
        .padding(.top, TotalListLayoutValue.Paddings.sideEffectRecordRowVerticalPadding)
    }
}

//============================================================================
//trend에서 사용하는 컴포넌트 공유 예정


//trend 의 sideEffectRecordsByDay
//부작용 데이터 컴포넌트 : 부작용 정보
struct SideEffectsInCell: View {
    
    var sideEffectsArr : [SideEffect]
    
    let columns: [GridItem] = [
        GridItem(.fixed(TotalListLayoutValue.Sizes.sideEffectRecordCellFixedWidth), spacing: TotalListLayoutValue.Paddings.sideEffectRecordCellHorizontalPadding),
        GridItem(.fixed(TotalListLayoutValue.Sizes.sideEffectRecordCellFixedWidth), spacing: TotalListLayoutValue.Paddings.sideEffectRecordCellHorizontalPadding),
        GridItem(.fixed(TotalListLayoutValue.Sizes.sideEffectRecordCellFixedWidth), spacing: TotalListLayoutValue.Paddings.sideEffectRecordCellHorizontalPadding),
        GridItem(.fixed(TotalListLayoutValue.Sizes.sideEffectRecordCellFixedWidth), spacing: TotalListLayoutValue.Paddings.sideEffectRecordCellHorizontalPadding),
        GridItem(.fixed(TotalListLayoutValue.Sizes.sideEffectRecordCellFixedWidth), spacing: TotalListLayoutValue.Paddings.sideEffectRecordCellHorizontalPadding)
        
    ]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing : TotalListLayoutValue.Paddings.sideEffectRecordCellVerticalPadding) {
            ForEach(sideEffectsArr, id: \.self) { sideEffect in
                SideEffectItem(curSideEffect : sideEffect)
            }
        }
        .padding(.vertical, TotalListLayoutValue.Paddings.sideEffectRecordCellVerticalPadding)
        .padding(.horizontal, TotalListLayoutValue.Paddings.sideEffectRecordRowHorizontalPadding)
        .frame(width: TotalListLayoutValue.Sizes.cardWidth)
    }
}


//trend 의 SideEffectRecordItem
//부작용 데이터 컴포넌트 : 부작용 이미지 + 이름
struct SideEffectItem: View {
    var curSideEffect : SideEffect
    
    var body: some View {
        VStack(spacing: 0) {
            Image(curSideEffect.getImageName())
            Text(curSideEffect.getSideEffectName())
                .font(.caption)
        }
    }
}


//trend 의 CaffeineRecordCell 에 padding (.vertical)로 제한하는 코드 추가 & Divider 삭제, 이외 동일
//카페인 데이터 컴포넌트 : 카페인 시간 + 카페인 정보
struct CaffeineCell: View {
    
    @ObservedObject var totalData : Datas
    var cellData : IntakeRecord
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .center, spacing: 0) {
                VStack(alignment: .leading, spacing: 0) {
                    Text(dateToTime(dateInfo: cellData.date))
                        .font(.caption)
                        .foregroundColor(.secondaryTextGray)
                        .padding(.bottom, TotalListLayoutValue.Paddings.dayRecordPadding)
                    HStack(alignment: .firstTextBaseline, spacing: 0) {
                        Text(cellData.beverage.name)
                            .font(.title3)
                            .padding(.trailing, TotalListLayoutValue.Paddings.textVerticalPadding)
                        Group {
                            Text(cellData.beverage.franchise.getFranchiseName())
                            Text("/")
                            Text(cellData.size.name)
                        }
                        .font(.caption)
                        .foregroundColor(.secondaryTextGray)
                    }
                }
                Spacer()
                HStack(alignment: .firstTextBaseline, spacing: 0) {
                    Text("\(totalData.sourceData.intakeManager.getCaffeineAmount(record: cellData))")
                        .font(.title)
                        .padding(.trailing, TotalListLayoutValue.Paddings.caffeineRecordAmountUnitPadding)
                    Text("mg")
                        .font(.subheadline)
                        .foregroundColor(.secondaryTextGray)
                }
            }
            .padding(.vertical, TotalListLayoutValue.Paddings.caffeineRecordRowVerticalPadding)
            .padding(.horizontal, TotalListLayoutValue.Paddings.caffeineRecordRowHorizontalPadding)
        }
    }
}


struct TotalListView_Previews: PreviewProvider {
    static var previews: some View {
        
        TotalListView()
        
//        NavigationView {
//            NavigationLink("to total list") {
//                TotalListView()
//            }
//        }
    }
}

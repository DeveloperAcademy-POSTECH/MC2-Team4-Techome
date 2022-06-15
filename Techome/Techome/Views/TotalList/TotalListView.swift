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
    }
}


//카페인 + 부작용 리스트 병합에 사용
struct DataListByDay : Hashable {
    var dataType: String
    var dataIndex: Int
}

final class datas: ObservableObject { //observable 객체 생성
    @Published var tmpDataSortedByDate : [ String : [DataListByDay] ]

    //offset 추가하기
    @Published var tmpOffsets = [ String : [CGFloat] ]()
    
//    init(tmpDataSortedByDate: [String : [DataListByDay]]) {
//        self.tmpDataSortedByDate = tmpDataSortedByDate
//
//        for key in self.tmpDataSortedByDate.keys {
//            self.tmpOffsets[key] = [CGFloat](repeating: .zero, count: tmpDataSortedByDate[key]!.count)
//        }
//    }
    
    init() {
        self.tmpDataSortedByDate =
            [ "2022.06.03" : [ DataListByDay(dataType: "drink", dataIndex: 1),
                               DataListByDay(dataType: "drink", dataIndex: 2),
                              DataListByDay(dataType: "sideEffect", dataIndex: 1),
                               DataListByDay(dataType: "sideEffect", dataIndex: 2) ],
              "2022.06.02" : [ DataListByDay(dataType: "drink", dataIndex: 3),
                               DataListByDay(dataType: "sideEffect", dataIndex: 3),
                              DataListByDay(dataType: "drink", dataIndex: 4),
                               DataListByDay(dataType: "sideEffect", dataIndex: 4) ],
              "2022.06.01" : [ DataListByDay(dataType: "drink", dataIndex: 5),
                               DataListByDay(dataType: "sideEffect", dataIndex: 5),
                              DataListByDay(dataType: "drink", dataIndex: 6) ],
              "2022.05.31" : [ DataListByDay(dataType: "drink", dataIndex: 7),
                               DataListByDay(dataType: "sideEffect", dataIndex: 6),
                              DataListByDay(dataType: "drink", dataIndex: 8) ]
            ]
        
//        self.tmpDataSortedByDate = tmpDataSortedByDate.sorted { $0.0 > $1.0 }
        
        for key in self.tmpDataSortedByDate.keys {
            self.tmpOffsets[key] = [CGFloat](repeating: .zero, count: tmpDataSortedByDate[key]!.count)
        }
    }
    
    func resetOffsets() {
        for key in self.tmpDataSortedByDate.keys {
            self.tmpOffsets[key] = [CGFloat](repeating: .zero, count: tmpDataSortedByDate[key]!.count)
        }
    }
    
    func deleteData(date : String, index : Int){
        self.tmpDataSortedByDate[date]!.remove(at: index)
        self.tmpOffsets[date]!.remove(at: index)
    }
    
    func countDatasByDate(date : String) -> Int {
        return tmpDataSortedByDate[date]!.count

    }
}

// 전체 리스트
struct TotalListView: View {
    
    @Environment(\.presentationMode) var presentationMode

    //TODO: 전체 데이터 받아오고 데이터 합쳐서 날짜로 정렬 및 그룹화하기

    
    @ObservedObject var testData = datas()
    
    var body: some View {
        
        ScrollView() {
            LazyVStack(spacing: 23) {
                
                ForEach(Array(testData.tmpDataSortedByDate.keys).sorted(by: >), id: \.self) { curDate in
                    TotalRecordsByDay(testDataByDay: testData, curDateByDay: curDate, dataCountByDay: testData.countDatasByDate(date: curDate))
                }
            }
            .padding(.horizontal, TotalListLayoutValue.Paddings.fullViewHorizontalPadding)
            .padding(.top, TotalListLayoutValue.Paddings.fullViewVerticalPadding) //navigation bar와 간격
        }
        .background(Color.backgroundCream)
//        .navigationTitle(Text("전체 리스트").font(.caption)) //TODO : navigation bar title toolbar custom으로 넣기
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
    }
}


//날짜별 카페인 + 부작용 데이터 : 날짜별로 스트레스 + 부작용 데이터 받아와서 뷰 만들기
struct TotalRecordsByDay: View {
    //카페인 + 부작용 리스트 병합 결과
    //TODO: datatype과 idx 활용해 리스트에 넣을 알맞은 데이터 찾기
    
    @ObservedObject var testDataByDay : datas
    var curDateByDay : String
    var dataCountByDay : Int
    
    
    var body: some View {
                
        VStack(alignment: .leading, spacing: 0) {
            Text(curDateByDay)
                .font(.title3)
                .fontWeight(.semibold)
                .padding(.bottom, TotalListLayoutValue.Paddings.dateVerticalPadding)
        
            VStack(spacing: 0) {
                ForEach(Array(testDataByDay.tmpDataSortedByDate[curDateByDay]!.enumerated()), id: \.element) { index, element in
//                ForEach(0 ..< dataCountByDay) { index in
                    ZStack {
                        //TODO: 삭제 배경 + 버튼 뷰 분리하기
                        //삭제 버튼 배경
                        HStack(spacing: 0) {
                            Color.white
                            Color.customRed
                        }
                        
                        //삭제 버튼
                        VStack{
                            Spacer()
                            HStack {
                                Spacer()
                                
                                Button(action: {
                                    print(dataCountByDay)
                                    print("삭제하기 : \(curDateByDay), \(index)")
                                    print(testDataByDay.tmpDataSortedByDate)
//                                    print(Array(testData.tmpDataSortedByDate[curDate]!.enumerated()))
                                    
                                    print("삭제 작업 수행하기")
                                    
                                    testDataByDay.deleteData(date: curDateByDay, index: index)
                                    
                                    print("삭제 작업 수행 완료")
                                    print(testDataByDay.tmpDataSortedByDate)
                                    
                                    print("모든 작업 완료")
                                    
                                }) {
                                    Text("삭제")
                                        .font(.body)
                                        .foregroundColor(Color.white)
                                }
                                .padding(.leading, TotalListLayoutValue.Sizes.cardWidth - 74)
                                
                                Spacer()
                            }
                            Spacer()
                        }

                        //row
                        //TODO: component 만들기
                        VStack (spacing : 0) {
                            
                            TotalRecordsByDayRow(testDataByDayRow: testDataByDay, curDateByDayRow: curDateByDay, rowIndexByDayRow: index, dataCountByDayRow : dataCountByDay)
                            
                            //마지막 데이터 다음 divider 없애기
                            if (index != dataCountByDay - 1) {
                                Divider()
                                    .padding(.horizontal, TotalListLayoutValue.Paddings.dividerHorizontalPadding)
                                    .background(Color.white)
                            }
                            
                        }
                    }
                }
            }
            .padding(.vertical, 3)
            .clipShape(RoundedRectangle(cornerRadius: 7))
            .shadow(color: Color.primaryShadowGray, radius: 7, x: 0, y: 0)
        }
    }
}


struct TotalRecordsByDayRow: View {
    @ObservedObject var testDataByDayRow : datas
    var curDateByDayRow : String
    var rowIndexByDayRow : Int
    var dataCountByDayRow : Int
//    @State public var element : DataListByDay
    
    var body: some View {
        
        switch testDataByDayRow.tmpDataSortedByDate[curDateByDayRow]![rowIndexByDayRow].dataType {
        case "drink":
            //TODO: 데이터 넘겨주기
            CaffeineRecordCellList()
                .padding(.horizontal, TotalListLayoutValue.Paddings.caffeineRecordRowHorizontalPadding)
                .background(Color.white)
                .offset(x: testDataByDayRow.tmpOffsets[curDateByDayRow]![rowIndexByDayRow])
                .gesture(
                    DragGesture()
                        .onChanged { gesture in
                            testDataByDayRow.resetOffsets()
                            testDataByDayRow.tmpOffsets[curDateByDayRow]![rowIndexByDayRow] = gesture.translation.width
                            if testDataByDayRow.tmpOffsets[curDateByDayRow]![rowIndexByDayRow] > 74 {
                                testDataByDayRow.tmpOffsets[curDateByDayRow]![rowIndexByDayRow] = .zero
                            }
                        }
                        .onEnded { _ in
                            if testDataByDayRow.tmpOffsets[curDateByDayRow]![rowIndexByDayRow] < -74 {
                                testDataByDayRow.tmpOffsets[curDateByDayRow]![rowIndexByDayRow] = -74
                            }
                            else if testDataByDayRow.tmpOffsets[curDateByDayRow]![rowIndexByDayRow] > -74 {
                                testDataByDayRow.tmpOffsets[curDateByDayRow]![rowIndexByDayRow] = .zero
                            }
                        }
                    )
        case "sideEffect":
            SideEffectRecordRow()
                .background(Color.white)
                .offset(x: testDataByDayRow.tmpOffsets[curDateByDayRow]![rowIndexByDayRow])
                .gesture(
                    DragGesture()
                        .onChanged { gesture in
                            testDataByDayRow.resetOffsets()
                            testDataByDayRow.tmpOffsets[curDateByDayRow]![rowIndexByDayRow] = gesture.translation.width
                            if testDataByDayRow.tmpOffsets[curDateByDayRow]![rowIndexByDayRow] > 74 {
                                testDataByDayRow.tmpOffsets[curDateByDayRow]![rowIndexByDayRow] = .zero
                            }
                        }
                        .onEnded { _ in

                            if testDataByDayRow.tmpOffsets[curDateByDayRow]![rowIndexByDayRow] <= -74 {
                                testDataByDayRow.tmpOffsets[curDateByDayRow]![rowIndexByDayRow] = -74
                            }
                            else if testDataByDayRow.tmpOffsets[curDateByDayRow]![rowIndexByDayRow] > -74 {
                                testDataByDayRow.tmpOffsets[curDateByDayRow]![rowIndexByDayRow] = .zero
                            }
                        }
                    )

        default :
            EmptyView()
        }
        
        
    }

//    func onChanged(value: DragGesture.Value) {
//        element.offset = value.translation.width
//        if element.offset > 74 {
//            element.offset = .zero
//        }
//    }
//
//    func onEnd() {
//        if element.offset <= -74 {
//            element.offset = -74
//        }
//        else if element.offset > -74 {
//            element.offset = .zero
//        }
//    }
    
}


//부작용 데이터 컴포넌트 : 부작용 시간 + 부작용 정보
struct SideEffectRecordRow: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 0) {
                Text("09:30")
                    .font(.caption)
                    .foregroundColor(.secondaryTextGray)
                Image(systemName: "exclamationmark.circle")
                    .resizable()
                    .frame(width: 15, height: 15)
                    .foregroundColor(.customRed)
                    .padding(.leading, 5)
            }
            .padding(.leading, TotalListLayoutValue.Paddings.sideEffectRecordRowHorizontalPadding)
            
            SideEffectRecordsByDayList()
        }
        .padding(.top, TotalListLayoutValue.Paddings.sideEffectRecordRowVerticalPadding)
    }
}

//============================================================================
//trend에서 사용하는 컴포넌트 공유 예정


//trend 의 sideEffectRecordsByDay 와 동일
//부작용 데이터 컴포넌트 : 부작용 정보
struct SideEffectRecordsByDayList: View {
    var body: some View {
        VStack(alignment: .center, spacing: TotalListLayoutValue.Paddings.sideEffectRecordCellVerticalPadding) {
            ForEach(0 ..< 2) { sideEffectRowIndex in
                HStack(alignment: .center, spacing: TotalListLayoutValue.Paddings.sideEffectRecordCellHorizontalPadding) {
                    //TODO: 임시 데이터 수
                    ForEach(0 ..< 5) { sideEffectItemIndex in
                        SideEffectRecordItemList()
                    }
                }
            }
        }
        .padding(.vertical, TotalListLayoutValue.Paddings.sideEffectRecordCellVerticalPadding)
        .frame(width: TotalListLayoutValue.Sizes.cardWidth)
    }
}


//trend 의 SideEffectRecordItem 과 동일
//부작용 데이터 컴포넌트 : 부작용 이미지 + 이름
struct SideEffectRecordItemList: View {
    var body: some View {
        VStack(spacing: 0) {
            Image("esophagitis")
            Text("식도염")
                .font(.caption)
        }
        .frame(width: TotalListLayoutValue.Sizes.sideEffectRecordCellFixedWidth)
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
                        .padding(.bottom, TotalListLayoutValue.Paddings.dayRecordPadding)
                    HStack(alignment: .firstTextBaseline, spacing: 0) {
                        Text("아메리카노")
                            .font(.title3)
                            .padding(.trailing, TotalListLayoutValue.Paddings.textVerticalPadding)
                        Text("스타벅스/Tall")
                            .font(.caption)
                            .foregroundColor(.secondaryTextGray)
                    }
                }
                Spacer()
                HStack(alignment: .firstTextBaseline, spacing: 0) {
                    Text("150")
                        .font(.title)
                        .padding(.trailing, TotalListLayoutValue.Paddings.caffeineRecordAmountUnitPadding)
                    Text("mg")
                        .font(.subheadline)
                        .foregroundColor(.secondaryTextGray)
                }
            }
            .padding(.vertical, TotalListLayoutValue.Paddings.caffeineRecordRowVerticalPadding)
//            Divider()
            
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

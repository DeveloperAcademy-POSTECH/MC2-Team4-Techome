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
//    var id = UUID()
    var dataType: String
    var dataIndex: Int
}

//var prevSelected : DataListByDay?


class datas: ObservableObject { //observable 객체 생성
    @Published var tmpDataSortedByDate : [ String : [DataListByDay] ]
    //offset 추가하기
    @Published var tmpOffsets = [ String : [CGFloat] ]()

    init(tmpDataSortedByDate: [String : [DataListByDay]]) {
        self.tmpDataSortedByDate = tmpDataSortedByDate
//        self.tmpOffsets = [CGFloat](repeating: .zero, count:.count)
        
        for key in self.tmpDataSortedByDate.keys {
            self.tmpOffsets[key] = [CGFloat](repeating: .zero, count: tmpDataSortedByDate[key]!.count)
        }
        
    }
    
    func resetOffsets() {
        for key in self.tmpDataSortedByDate.keys {
            self.tmpOffsets[key] = [CGFloat](repeating: .zero, count: tmpDataSortedByDate[key]!.count)
        }
    }
    
    func countRows() -> Int {
        return tmpDataSortedByDate.count
    }
    
}



// 전체 리스트
struct TotalListView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
//    @State var offsetArr = [CGFloat]()
    //TODO: 전체 데이터 받아오고 데이터 합쳐서 날짜로 정렬 및 그룹화하기
    
    @ObservedObject var testData = datas(tmpDataSortedByDate:
                        [ "2022.06.03" : [ DataListByDay(dataType: "drink", dataIndex: 1),
                                           DataListByDay(dataType: "sideEffect", dataIndex: 1),
                                          DataListByDay(dataType: "drink", dataIndex: 2) ],
                          "2022.06.02" : [ DataListByDay(dataType: "drink", dataIndex: 1),
                                           DataListByDay(dataType: "sideEffect", dataIndex: 1),
                                          DataListByDay(dataType: "drink", dataIndex: 2) ],
                          "2022.06.01" : [ DataListByDay(dataType: "drink", dataIndex: 1),
                                           DataListByDay(dataType: "sideEffect", dataIndex: 1),
                                          DataListByDay(dataType: "drink", dataIndex: 2) ],
                        ])
    
//    init() {
//        @State var offsets = [CGFloat](repeating: .zero, count: tmpFullData.count)
//    }
    
    //전체 데이터 수 9개라고 가정
//    @State var offsets = [CGFloat](repeating: .zero, count: 9)
    
    var body: some View {
        
//        let keys = tmpDataSortedByDate.map{$0.key}
        
        ScrollView() {
            LazyVStack(spacing: 23) {
//                ForEach(1 ..< 10) { _ in
//                    TotalRecordsByDay(tmpDataListByDayArr: $tmpData, curDate: "2022.06.03", dataCount: tmpData.count)
//                }
//                ForEach(0 ..< testData.count()) { index in
//                    TotalRecordsByDay(testData: testData, curDate: Array(testData)[index].key)
//                }
                
                ForEach(Array(testData.tmpDataSortedByDate.keys), id: \.self) { curDate in
                    TotalRecordsByDay(testData: testData, curDate: curDate, dataCount: testData.countRows())
                }
            }
            .padding(.horizontal, TotalListLayoutValue.Paddings.fullViewHorizontalPadding)
            .padding(.top, TotalListLayoutValue.Paddings.fullViewVerticalPadding) //navigation bar와 간격
        }
        .background(Color.backgroundCream)
        .navigationTitle(Text("전체 리스트").font(.caption)) //TODO : navigation bar title toolbar custom으로 넣기
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
    
    @ObservedObject var testData : datas
    public var curDate : String
    public var dataCount : Int
    
//    @Binding public var fullData : [DataListByDay]
    
//    @State private var offsets = [CGFloat](repeating: .zero, count: 3)
//    private var index : Int = 1
    
//    init(curDate: String, tmpDataListByDayArr: [DataListByDay]) {
//        self.tmpDataListByDayArr = tmpDataListByDayArr
//        self.curDate = curDate
//        self.dataCount = tmpDataListByDayArr.count
//    }
    
    var body: some View {
        
//        let dataCount = tmpDataListByDayArr.count
        
        VStack(alignment: .leading, spacing: 0) {
            Text(curDate)
                .font(.title3)
                .fontWeight(.semibold)
                .padding(.bottom, TotalListLayoutValue.Paddings.dateVerticalPadding)
        
            VStack(spacing: 0) {
                ForEach(Array(testData.tmpDataSortedByDate[curDate]!.enumerated()), id: \.element) { index, element in
                    ZStack {
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
                                
                                Button(action: {}) {
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
                            
                            TotalRecordsByDayRow(testData: testData, curDate: curDate, rowIndex: index, element: element)
                            
                            //마지막 데이터 다음 divider 없애기
                            if (index != dataCount - 1) {
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
    
    //    @Binding public var fullData : [DataListByDay]
    //    @Binding public var tmpDataListByDayArr : [DataListByDay]
    @ObservedObject var testData : datas
    var curDate : String
    var rowIndex : Int
    @State public var element : DataListByDay
    
    var body: some View {
        
        switch element.dataType {
        case "drink":
            //TODO: 데이터 넘겨주기
            CaffeineRecordCellList()
//                                    .background(Color.white)
                .padding(.horizontal, TotalListLayoutValue.Paddings.caffeineRecordRowHorizontalPadding)
                .background(Color.white)
                .offset(x: testData.tmpOffsets[curDate]![rowIndex])
                .gesture(
                    DragGesture()
                        .onChanged { gesture in
//                            for index in 0 ..< fullData.count {
//                                fullData[index].offset = .zero
//                            }
                            testData.resetOffsets()
                            testData.tmpOffsets[curDate]![rowIndex] = gesture.translation.width
                            if testData.tmpOffsets[curDate]![rowIndex] > 74 {
                                testData.tmpOffsets[curDate]![rowIndex] = .zero
                            }
                        }
                        .onEnded { _ in
                            if testData.tmpOffsets[curDate]![rowIndex] < -74 {
                                testData.tmpOffsets[curDate]![rowIndex] = -74
//                                element.offset = element.offset
                            }
                            else if testData.tmpOffsets[curDate]![rowIndex] > -74 {
                                testData.tmpOffsets[curDate]![rowIndex] = .zero
                            }
                        }
                    )
        case "sideEffect":
            SideEffectRecordRow()
                .background(Color.white)
                .offset(x: testData.tmpOffsets[curDate]![rowIndex])
                .gesture(
                    DragGesture()
                        .onChanged { gesture in
                            testData.resetOffsets()
                            testData.tmpOffsets[curDate]![rowIndex] = gesture.translation.width
                            if testData.tmpOffsets[curDate]![rowIndex] > 74 {
                                testData.tmpOffsets[curDate]![rowIndex] = .zero
                            }
                        }
                        .onEnded { _ in

                            if testData.tmpOffsets[curDate]![rowIndex] <= -74 {
                                testData.tmpOffsets[curDate]![rowIndex] = -74
                            }
                            else if testData.tmpOffsets[curDate]![rowIndex] > -74 {
                                testData.tmpOffsets[curDate]![rowIndex] = .zero
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

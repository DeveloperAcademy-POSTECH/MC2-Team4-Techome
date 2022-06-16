//
//  TotalListView.swift
//  Techome
//
//  Created by Kimhwiwon on 2022/06/10.
//

import SwiftUI

var dataResult : [String : [TotalDataCell]] =
    [ "2022.06.03" : [ TotalDataCell(dataType: "drink", dataIndex: 1),
                       TotalDataCell(dataType: "drink", dataIndex: 2),
                      TotalDataCell(dataType: "sideEffect", dataIndex: 1),
                       TotalDataCell(dataType: "sideEffect", dataIndex: 2) ],
      "2022.06.02" : [ TotalDataCell(dataType: "drink", dataIndex: 3),
                       TotalDataCell(dataType: "sideEffect", dataIndex: 3),
                      TotalDataCell(dataType: "drink", dataIndex: 4),
                       TotalDataCell(dataType: "sideEffect", dataIndex: 4) ],
      "2022.06.01" : [ TotalDataCell(dataType: "drink", dataIndex: 5),
                       TotalDataCell(dataType: "sideEffect", dataIndex: 5),
                      TotalDataCell(dataType: "drink", dataIndex: 6) ],
      "2022.05.31" : [ TotalDataCell(dataType: "drink", dataIndex: 7),
                       TotalDataCell(dataType: "sideEffect", dataIndex: 6),
                      TotalDataCell(dataType: "drink", dataIndex: 8) ]
    ]

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
struct TotalDataCell : Hashable {
    var dataType: String
    var dataIndex: Int
}

final class datas: ObservableObject { //observable 객체 생성
    @Published var dataSortedByDate = [ String : [TotalDataCell] ]()

    //offset 추가하기
    @Published var offsetsArr = [ String : [CGFloat] ]()
    @Published var datesArr = [String]()
        
    init(dataSortedByDate : [ String : [TotalDataCell]] ) {
        
        self.dataSortedByDate = dataSortedByDate
        
        for key in self.dataSortedByDate.keys {
            self.offsetsArr[key] = [CGFloat](repeating: .zero, count: self.dataSortedByDate[key]!.count)
            self.datesArr.append(key)
        }
        
        self.datesArr = datesArr.sorted(by: >)
    }
    
    func deleteData(curDate : String, index : Int) {
        self.dataSortedByDate[curDate]!.remove(at: index)
        self.offsetsArr[curDate]!.remove(at:index)
        
        if (self.dataSortedByDate[curDate]!.count <= 0) {
            self.datesArr.remove(at: self.datesArr.firstIndex(of: curDate)!)
        }
    }
    
    func resetOffsets() {
        for date in self.datesArr {
            self.offsetsArr[date] = [CGFloat](repeating: .zero, count: dataSortedByDate[date]!.count)
        }
    }
}

// 전체 리스트
struct TotalListView: View {
    
    @Environment(\.presentationMode) var presentationMode

    //TODO: 전체 데이터 받아오고 데이터 합쳐서 날짜로 정렬 및 그룹화하기
    
    
    @ObservedObject var totalData = datas(dataSortedByDate: dataResult)
    
    var body: some View {
        ScrollView {
        
            LazyVStack {
                ForEach(totalData.datesArr, id: \.self) { curDate in
                    TotalListByDay(totalData: totalData, curDate: curDate)
                }
            }
            
        }
        
    }
}


//날짜별 카페인 + 부작용 데이터
//TODO: 날짜별로 스트레스 + 부작용 데이터 받아와서 뷰 만들기
struct TotalListByDay: View {
    @ObservedObject var totalData : datas
    var curDate : String
    
    var body: some View {
        Text("\(curDate)")
        
        VStack {
            ForEach(Array(totalData.dataSortedByDate[curDate]!.enumerated()), id: \.element) { index, cell in
                ZStack{
                    HStack(spacing: 0){
                        Color.white
                        Color.customRed
                    }
                    
                    Button(action: {
                        totalData.deleteData(curDate : curDate, index : index)
                    }) {
                        deleteButton()
                    }
                    
                    Cell(curCell : cell)
                        .offset(x: totalData.offsetsArr[curDate]![index])
                        .gesture(
                            DragGesture()
                                .onChanged { gesture in
                                    onChanged(value: gesture, curDate: curDate, index: index)
                                }
                                .onEnded { _ in
                                    onEnd(curDate: curDate, index: index)
                                }
                            )
                }
            }
        }
    }
    
    //제스쳐 함수
    //onChanged : 제스쳐 움직임을 cell에 실시간으로 반영
    //오른쪽 방향으로 움직일 경우 cell 위치 원상복귀
    func onChanged(value: DragGesture.Value, curDate: String, index: Int) {
        totalData.resetOffsets()
        totalData.offsetsArr[curDate]![index] = value.translation.width
        if totalData.offsetsArr[curDate]![index] > 74 {
            totalData.offsetsArr[curDate]![index] = .zero
        }
    }
    //onEnd : 제스쳐가 끝나는 시점 체크
    //왼쪽으로 74 이상 움직였을 경우 cell이 74만큼 왼쪽으로 이동된 상태 유지, 왼쪽으로 74 이상 움직이지 않았을 경우 cell 위치 원상복귀
    func onEnd(curDate: String, index: Int){
        if totalData.offsetsArr[curDate]![index] < -74 {
            totalData.offsetsArr[curDate]![index] = -74
        }
        else if totalData.offsetsArr[curDate]![index] > -74 {
            totalData.offsetsArr[curDate]![index] = .zero
        }
    }
}

//cell 뒤에 배치되는 버튼 뷰
struct deleteButton: View {
    
    var body: some View {

        Text("삭제")
            .font(.body)
            .foregroundColor(Color.white)
            .padding(.leading, TotalListLayoutValue.Sizes.cardWidth - 74)
    }
    
}

struct Cell: View {
    
    var curCell : TotalDataCell
    
    var body : some View {
        Group{
            switch curCell.dataType {
                
            case "drink" :
                CaffeineRecordCellList()
                
            case "sideEffect" :
                SideEffectRecordRow()
                
            default :
                EmptyView()
                
            }
        }
        .background(Color.white)
    }
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

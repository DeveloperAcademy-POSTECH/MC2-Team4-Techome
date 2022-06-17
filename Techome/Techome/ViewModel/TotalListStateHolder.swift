//
//  TotalListStateHolder.swift
//  Techome
//
//  Created by Kimhwiwon on 2022/06/17.
//
import Foundation
import SwiftUI

final class Datas: ObservableObject { //observable 객체 생성
    
    @Published var dataSortedByDate = [ String : [TotalDataCell] ]() //뷰를 만들 때 최종으로 사용하는 데이터
    @Published var offsetsArr = [ String : [CGFloat] ]()
    @Published var datesArr = [String]()
    let sourceData = totalListSourceData() //카페인, 부작용 접근 sourceData 통해서 접근하기
    let collectData = totalListCollectData() //데이터 합치는 함수를 불러오기 위함
        
    init() {
        //데이터 만들기
        self.dataSortedByDate = collectData.makeData(intakes: sourceData.intakes, sideEffects: sourceData.sideEffects)
        
        for key in self.dataSortedByDate.keys {
            self.offsetsArr[key] = [CGFloat](repeating: .zero, count: self.dataSortedByDate[key]!.count)
            self.datesArr.append(key)
        }
        
        self.datesArr = datesArr.sorted(by: >)
        
        print(self.dataSortedByDate)
//        let hihi = totalListSourceData()
//        print(hihi.intakes)
//        print(hihi.sideEffects)
    }
    
    //선택된 cell 삭제
    func deleteData(curDate : String, index : Int) {
        guard self.dataSortedByDate[curDate] != nil else {
            return
        }
        self.dataSortedByDate[curDate]?.remove(at: index)

        guard self.offsetsArr[curDate] != nil else {
            return
        }
        self.offsetsArr[curDate]?.remove(at: index)

        
        guard let dateIndex = self.datesArr.firstIndex(of: curDate) else {
            return
        }
        
        if (self.dataSortedByDate[curDate]!.count <= 0 ) {
            self.datesArr.remove(at: dateIndex)
        }
    }
    
    //모든 cell 원위치
    func resetOffsets() {
        for date in self.datesArr {
            self.offsetsArr[date] = [CGFloat](repeating: .zero, count: dataSortedByDate[date]!.count)
        }
    }
    
}

struct totalListSourceData {
    let intakeManager = IntakeManager.shared
    let sideEffectManager = SideEffectManager.shared
    let intakes : [IntakeRecord]
    let sideEffects : [SideEffectRecord]
    
    
    init() {
        intakes = intakeManager.getAllRecords()
        sideEffects = sideEffectManager.getAllRecords()
        print(intakes)
        print(sideEffects)
    }
}


class totalListCollectData {
//    struct TotalDataCell {
//        var date : Date
//        var dataType : String
//        var dataIndex : Int
//    }
    
    var finalData = [ String : [TotalDataCell] ]()
    var sourceDataMerged = [TotalDataCell]() //카페인, 부작용 데이터 합친 결과 (date, datatype, dataindex) -> 완성 후 date 기준으로 정렬
    var sourceDataGrouped = [TotalDataCell]() //합친 데이터의 date를 yyyy.mm.dd 형식으로 바꾼 결과
    
    //view에서 활용할 data 구조 만들기
    func makeData(intakes : [IntakeRecord], sideEffects : [SideEffectRecord]) -> [String : [TotalDataCell]]{
        //카페인, 부작용 데이터 합치기
        for (i, intake) in intakes.enumerated() {
            sourceDataMerged.append(TotalDataCell(date: intake.date, dataType: "intake", dataIndex: i))
        }
        print("카페인 합치기 완료")
        print(sourceDataMerged)
        
        for (i, sideEffect) in sideEffects.enumerated() {
            sourceDataMerged.append(TotalDataCell(date: sideEffect.date, dataType: "sideEffect", dataIndex: i))
        }
        print("부작용 합치기 완료")
        print(sourceDataMerged)
        
        //date 기준으로 전체 데이터 내림차순 정렬
        self.sourceDataMerged = self.sourceDataMerged.sorted{
            $0.date > $1.date
        }
        print("date 기준으로 정렬 완료")
        
        //딕셔너리 형태로 최종 데이터 만들기 (날짜 : [data배열])
//        for dataCell in sourceDataMerged {
//            sourceDataGrouped.append(TotalDataCell(date: dateToString(dateInfo : dataCell.date), dataType: dataCell.dataType, dataIndex: dataCell.dataIndex))
//        }
        
//        self.finalData = Dictionary(grouping: sourceDataGrouped, by: { $0.(dateToString(dateInfo : dataCell.date)) })
//        self.finalData = Dictionary(grouping: sourceDataMerged, by: { $0.(dateToString(dateInfo : dataCell.date)) })
        
        self.finalData = Dictionary(grouping: sourceDataMerged) { (oneData) -> String in
            let dateString = dateToString(dateInfo: oneData.date)
            return dateString
        }
        
        //그룹 내에서 시간 기준 정렬
//        self.finalData =
        for (dateKey, dataValue) in finalData {
            self.finalData[dateKey] = dataValue.sorted(by: {$0.date < $1.date})

        }

        print(finalData)
        
        print("최종 데이터 만들기 완료")
        
        return finalData
    }

    //date를 년.월.일 형식의 string으로 바꿔주는 함수
    func dateToString(dateInfo : Date) -> String {
        
        var dateString : String
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        dateString = dateFormatter.string(from: dateInfo)
        
        return dateString
    }
    
}

func dateToTime(dateInfo : Date) -> String {
    
    var dateString : String
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HH:mm"
    dateString = dateFormatter.string(from: dateInfo)
    
    return dateString
}



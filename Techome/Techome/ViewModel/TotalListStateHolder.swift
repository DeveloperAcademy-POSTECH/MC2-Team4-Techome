//
//  TotalListStateHolder.swift
//  Techome
//
//  Created by Kimhwiwon on 2022/06/17.
//
import Foundation
import SwiftUI

let intakeManager = IntakeManager.shared
let sideEffectManager = SideEffectManager.shared

struct TotalDataCell : Hashable {
    var date = Date()
    var dataType: String
    var dataIndex: Int
}

final class totalListSourceData {
    var intakes = [IntakeRecord]()
    var sideEffects = [SideEffectRecord]()

    func loadData() {
        self.intakes = intakeManager.getAllRecords()
        self.sideEffects = sideEffectManager.getAllRecords()
    }
}

final class Datas: ObservableObject { //observable 객체 생성
    @Published var dataSortedByDate = [ String : [TotalDataCell] ]() //뷰를 만들 때 최종으로 사용하는 데이터
    @Published var offsetsArr = [ String : [CGFloat] ]() //각 cell이 슬라이드 된 정도 저장
    @Published var datesArr = [String]() //데이터에 존재하는 날짜 리스트
    var sourceData = totalListSourceData() //카페인, 부작용 데이터 sourceData 통해서 접근하기
    var collectData = totalListCollectData() //데이터 합치는 함수를 불러오기 위함
    
    //데이터 로드
    func loadData() {
        sourceData.loadData()
        dataSortedByDate.removeAll()
        offsetsArr.removeAll()
        datesArr.removeAll()
        self.dataSortedByDate = collectData.makeData(intakes: sourceData.intakes, sideEffects: sourceData.sideEffects)
        for key in self.dataSortedByDate.keys {
            self.offsetsArr[key] = [CGFloat](repeating: .zero, count: self.dataSortedByDate[key]!.count)
            self.datesArr.append(key)
        }
        self.datesArr = datesArr.sorted(by: >)
    }
    
    //선택된 cell 삭제
    func deleteData(curCell : TotalDataCell, curDate : String, index : Int) {
        //실제 데이터에서 삭제
        if curCell.dataType == "intake"{
            intakeManager.deleteRecord(intakeRecord: sourceData.intakes[curCell.dataIndex])
        } else if curCell.dataType == "sideEffect" {
            sideEffectManager.deleteRecord(sideEffectRecord: sourceData.sideEffects[curCell.dataIndex])
        }
        
        //클라이언트 단에서 사용하는 데이터에서 삭제 (dataSortedByDate, offsetsArr, datesArr)
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

class totalListCollectData {
    var finalData = [ String : [TotalDataCell] ]()
    var sourceDataMerged = [TotalDataCell]() //카페인, 부작용 데이터 합친 결과 (date, datatype, dataindex) -> 완성 후 date 기준으로 정렬
    
    //view에서 활용할 data 구조 만들기
    func makeData(intakes : [IntakeRecord], sideEffects : [SideEffectRecord]) -> [String : [TotalDataCell]]{
        sourceDataMerged.removeAll()
        finalData.removeAll()
        
        //카페인, 부작용 데이터 합치기
        for (i, intake) in intakes.enumerated() {
            sourceDataMerged.append(TotalDataCell(date: intake.date, dataType: "intake", dataIndex: i))
        }
        for (i, sideEffect) in sideEffects.enumerated() {
            sourceDataMerged.append(TotalDataCell(date: sideEffect.date, dataType: "sideEffect", dataIndex: i))
        }
        
        //date 기준으로 전체 데이터 내림차순 정렬
        self.sourceDataMerged = self.sourceDataMerged.sorted{
            $0.date > $1.date
        }

        //date 기준으로 그룹핑
        self.finalData = Dictionary(grouping: sourceDataMerged) { (oneData) -> String in
            let dateString = dateToString(dateInfo: oneData.date)
            return dateString
        }
        
        //그룹 내에서 시간 기준 정렬
        for (dateKey, dataValue) in finalData {
            self.finalData[dateKey] = dataValue.sorted(by: {$0.date < $1.date})
        }
        
        return finalData
    }
}

//date를 년.월.일 형식의 string으로 바꿔주는 함수
func dateToString(dateInfo : Date) -> String {
    
    var dateString : String
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy.MM.dd"
    dateString = dateFormatter.string(from: dateInfo)
    
    return dateString
}

//date를 시간. 분 형식의 string으로 바꿔주는 함수
func dateToTime(dateInfo : Date) -> String {
    
    var dateString : String
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HH:mm"
    dateString = dateFormatter.string(from: dateInfo)
    
    return dateString
}



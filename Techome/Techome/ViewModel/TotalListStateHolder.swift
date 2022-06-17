//
//  TotalListStateHolder.swift
//  Techome
//
//  Created by Kimhwiwon on 2022/06/17.
//
import Foundation
import SwiftUI



struct sourceDataCell {
    var date : Date
    var dataType : String
    var dataIndex : Int
}

struct groupDataCell : Hashable {
    var date : String
    var dataType : String
    var dataIndex : Int
}


final class datas: ObservableObject { //observable 객체 생성
    
    @Published var dataGroupedByDate = [ String : [groupDataCell] ]()
    @Published var offsetsArr = [ String : [CGFloat] ]()
    @Published var datesArr = [String]()
        
    init() {
        self.dataGroupedByDate = sourceData.shared.makeData()
        for key in self.dataGroupedByDate.keys {
            self.offsetsArr[key] = [CGFloat](repeating: .zero, count: self.dataGroupedByDate[key]!.count)
            self.datesArr.append(key)
        }
        self.datesArr = datesArr.sorted(by: >)
    }
    
    //선택된 cell 삭제
    func deleteData(curDate : String, index : Int) {
        self.dataGroupedByDate[curDate]!.remove(at: index)
        self.offsetsArr[curDate]!.remove(at:index)
        
        if (self.dataGroupedByDate[curDate]!.count <= 0) {
            self.datesArr.remove(at: self.datesArr.firstIndex(of: curDate)!)
        }
    }
    
    //모든 cell 원위치
    func resetOffsets() {
        for date in self.datesArr {
            self.offsetsArr[date] = [CGFloat](repeating: .zero, count: dataGroupedByDate[date]!.count)
        }
    }
}

final class sourceData {
    let intakeManager2 = IntakeManager.shared
    let sideEffectManager2 = SideEffectManager.shared
    let intakes : [IntakeRecord]
    let sideEffects : [SideEffectRecord]
    var sourceDataMerged = [sourceDataCell]()
    var sourceDataGrouped = [groupDataCell]()
    var finalData = [String : [groupDataCell]]()
    
    static let shared = sourceData()
    
    init() {
        self.intakes = self.intakeManager2.getAllRecords()
        self.sideEffects = self.sideEffectManager2.getAllRecords()
        print(self.intakes)
    }
    
    //view에서 활용할 data 구조 만들기
    func makeData() -> [String : [groupDataCell]]{
        //카페인, 부작용 데이터 합치기
        for (i, intake) in intakes.enumerated() {
            sourceDataMerged.append(sourceDataCell(date: intake.date, dataType: "intake", dataIndex: i))
        }
        print("카페인 합치기 완료")
        print(sourceDataMerged)
        
        for (i, sideEffect) in sideEffects.enumerated() {
            sourceDataMerged.append(sourceDataCell(date: sideEffect.date, dataType: "sideEffect", dataIndex: i))
        }
        print("부작용 합치기 완료")
        print(sourceDataMerged)
        
        //date 기준으로 전체 데이터 내림차순 정렬
        self.sourceDataMerged = self.sourceDataMerged.sorted{
            $0.date > $1.date
        }
        print("date 기준으로 정렬 완료")
        
        //딕셔너리 형태로 최종 데이터 만들기 (날짜 : [data배열])
        for dataCell in sourceDataMerged {
            sourceDataGrouped.append(groupDataCell(date: dateToString(dateInfo : dataCell.date), dataType: dataCell.dataType, dataIndex: dataCell.dataIndex))
        }
        print("최종 데이터 만들기 완료")
        
        self.finalData = Dictionary(grouping: sourceDataGrouped, by: { $0.date })
        print(finalData)
        
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

//final class datas: ObservableObject { //observable 객체 생성
//
//    @Published var dataGroupedByDate = [ String : [groupDataCell] ]()
//    @Published var offsetsArr = [ String : [CGFloat] ]()
//    @Published var datesArr = [String]()
//    let source : sourceData
//
//    init() {
//        self.source = sourceData()
//        self.dataGroupedByDate = source.finalData
//
//        for key in self.dataGroupedByDate.keys {
//            self.offsetsArr[key] = [CGFloat](repeating: .zero, count: self.dataGroupedByDate[key]!.count)
//            self.datesArr.append(key)
//        }
//        self.datesArr = datesArr.sorted(by: >)
//    }
//
//    //선택된 cell 삭제
//    func deleteData(curDate : String, index : Int) {
//        self.dataGroupedByDate[curDate]!.remove(at: index)
//        self.offsetsArr[curDate]!.remove(at:index)
//
//        if (self.dataGroupedByDate[curDate]!.count <= 0) {
//            self.datesArr.remove(at: self.datesArr.firstIndex(of: curDate)!)
//        }
//    }
//
//    //모든 cell 원위치
//    func resetOffsets() {
//        for date in self.datesArr {
//            self.offsetsArr[date] = [CGFloat](repeating: .zero, count: dataGroupedByDate[date]!.count)
//        }
//    }
//}

//final class sourceData {
//    let intakeManager2 = IntakeManager.shared
//    let sideEffectManager2 = SideEffectManager.shared
//    let intakes : [IntakeRecord]
//    let sideEffects : [SideEffectRecord]
//    var sourceDataMerged = [sourceDataCell]()
//    var sourceDataGrouped = [groupDataCell]()
//    var finalData = [String : [groupDataCell]]()
//
//    init() {
//        self.intakes = self.intakeManager2.getAllRecords()
//        self.sideEffects = self.sideEffectManager2.getAllRecords()
//        print(self.intakes)
//        self.makeData()
//    }
//
//    //view에서 활용할 data 구조 만들기
//    func makeData() {
//        //카페인, 부작용 데이터 합치기
//        for (i, intake) in intakes.enumerated() {
//            sourceDataMerged.append(sourceDataCell(date: intake.date, dataType: "intake", dataIndex: i))
//        }
//        print("카페인 합치기 완료")
//        print(sourceDataMerged)
//
//        for (i, sideEffect) in sideEffects.enumerated() {
//            sourceDataMerged.append(sourceDataCell(date: sideEffect.date, dataType: "sideEffect", dataIndex: i))
//        }
//        print("부작용 합치기 완료")
//        print(sourceDataMerged)
//
//        //date 기준으로 전체 데이터 내림차순 정렬
//        self.sourceDataMerged = self.sourceDataMerged.sorted{
//            $0.date > $1.date
//        }
//        print("date 기준으로 정렬 완료")
//
//        //딕셔너리 형태로 최종 데이터 만들기 (날짜 : [data배열])
//        for dataCell in sourceDataMerged {
//            sourceDataGrouped.append(groupDataCell(date: dateToString(dateInfo : dataCell.date), dataType: dataCell.dataType, dataIndex: dataCell.dataIndex))
//        }
//        print("최종 데이터 만들기 완료")
//
//        self.finalData = Dictionary(grouping: sourceDataGrouped, by: { $0.date })
//        print(finalData)
//    }
//
//    //date를 년.월.일 형식의 string으로 바꿔주는 함수
//    func dateToString(dateInfo : Date) -> String {
//
//        var dateString : String
//
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy.MM.dd"
//        dateString = dateFormatter.string(from: dateInfo)
//
//        return dateString
//    }
//
//}


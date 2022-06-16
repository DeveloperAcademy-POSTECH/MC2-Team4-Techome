//
//  TotalListStateHolder.swift
//  Techome
//
//  Created by Kimhwiwon on 2022/06/17.
//

import Foundation
import SwiftUI

final class datas: ObservableObject { //observable 객체 생성
    
    @Published var dataSortedByDate = [ String : [TotalDataCell] ]()
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
    
    //선택된 cell 삭제
    func deleteData(curDate : String, index : Int) {
        self.dataSortedByDate[curDate]!.remove(at: index)
        self.offsetsArr[curDate]!.remove(at:index)
        
        if (self.dataSortedByDate[curDate]!.count <= 0) {
            self.datesArr.remove(at: self.datesArr.firstIndex(of: curDate)!)
        }
    }
    
    //모든 cell 원위치
    func resetOffsets() {
        for date in self.datesArr {
            self.offsetsArr[date] = [CGFloat](repeating: .zero, count: dataSortedByDate[date]!.count)
        }
    }
}


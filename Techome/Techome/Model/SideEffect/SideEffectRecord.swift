//
//  SideEffectRecord.swift
//  Techome
//
//  Created by Yeongwoo Kim on 2022/06/09.
//

import Foundation

struct SideEffectRecord: Hashable, Codable{
    var date: Date
    var sideEffect: [SideEffect]
}

enum SideEffect: String, Hashable, Codable{
    case fastHeartRate = "fastHeartRate"            //  두근거림
    case shake = "shake"                            //  손떨림
    case esophagitis = "esophagitis"                //  식도염
    case depression = "depression"                  //  우울함
    case heartburn = "heartburn"                    //
    case dehydration = "dehydration"
    case restlessness = "restlessness"
    case lethargy = "lethargy"
    case insomnia = "insomnia"
    case dizziness = "dizziness"
    
    func getImageName() -> String{
        return self.rawValue
    }
    
    func getSideEffectName() -> String{
        switch(self){
        case .fastHeartRate:
            return "두근거림"
        case .shake:
            return "손떨림"
        case .esophagitis:
            return "식도염"
        case .depression:
            return "우울함"
        case .heartburn:
            return "속쓰림"
        case .dehydration:
            return "탈수"
        case .restlessness:
            return "불안감"
        case .lethargy:
            return "무기력"
        case .insomnia:
            return "불면증"
        case .dizziness:
            return "현기증"
        }
    }
}

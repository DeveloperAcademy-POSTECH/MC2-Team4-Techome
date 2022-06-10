//
//  SideEffectRecord.swift
//  Techome
//
//  Created by Yeongwoo Kim on 2022/06/09.
//

import Foundation

struct SideEffectRecord: Hashable, Codable {
    var uuid = UUID()
    var date: Date
    var sideEffect: [SideEffect]
}

enum SideEffect: String, CaseIterable, Hashable, Codable {
    case fastHeartRate = "fastHeartRate"            //  두근거림
    case shake = "shake"                            //  손떨림
    case esophagitis = "esophagitis"                //  식도염
    case depression = "depression"                  //  우울함
    case heartburn = "heartburn"                    //  속쓰림
    case dehydration = "dehydration"                //  탈수
    case restlessness = "restlessness"              //  불안감
    case lethargy = "lethargy"                      //  무기력
    case insomnia = "insomnia"                      //  불면증
    case dizziness = "dizziness"                    //  현기증
    
    func getImageName() -> String {
        return self.rawValue
    }
    
    func getSideEffectName() -> String {
        switch self {
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

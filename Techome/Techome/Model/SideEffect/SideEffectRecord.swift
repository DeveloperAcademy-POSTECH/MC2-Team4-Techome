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
    var sideEffects: [SideEffect]
}

enum SideEffect: Int, CaseIterable, Hashable, Codable {
    case fastHeartRate = 0                  //  두근거림
    case shake = 1                          //  손떨림
    case esophagitis = 2                    //  식도염
    case depression = 3                     //  우울함
    case heartburn = 4                      //  속쓰림
    case dehydration = 5                    //  탈수
    case restlessness = 6                   //  불안감
    case lethargy = 7                       //  무기력
    case insomnia = 8                       //  불면증
    case dizziness = 9                      //  현기증
    
    func getImageName() -> String {
        switch self {
        case .fastHeartRate:
            return "fastHeartRate"
        case .shake:
            return "shake"
        case .esophagitis:
            return "esophagitis"
        case .depression:
            return "depression"
        case .heartburn:
            return "heartburn"
        case .dehydration:
            return "dehydration"
        case .restlessness:
            return "restlessness"
        case .lethargy:
            return "lethargy"
        case .insomnia:
            return "insomnia"
        case .dizziness:
            return "dizziness"
        }
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

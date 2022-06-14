//
//  TestView_P.swift
//  Techome
//
//  Created by Yeongwoo Kim on 2022/06/13.
//

import SwiftUI

struct TestView_P: View {
    let intakeManager = IntakeManager.shared
    let sideEffectManager = SideEffectManager.shared
    let beverageManager = BeverageManager.shared
    
    @State var index = 0
    
    @State var beverageName = ""
        
    var body: some View {
        VStack{
            Button(action: {
                print("[섭취 기록 추가]")
                
                let data = beverageManager.getAllBeverages()
                
                intakeManager.addRecord(beverage: data[index], sizeInfo: data[index].sizeInfo[0], addedShotCount: index)
                index+=1
            }) {
                Text("섭취 기록 추가하기")
            }

            Button(action: {
                print("[총 섭취 기록]")
                
                let records = intakeManager.getAllRecords()
                
                for record in records {
                    print("시간: \(record.date), 커피: \(record.beverage.name), 사이즈: \(record.size.name), 양: \(record.beverage.franchise.getSizeAmount(size: record.size.name)), 추가 샷 수: \(record.addedShotCount), 카페인 양: \(intakeManager.getCaffeineAmount(record: record))")
                }
            }) {
                Text("섭취 기록 보기")
            }
            
            Button(action: {
                print("[오늘 섭취 기록]")
                
                let records = intakeManager.getDailyRecords(date: Date.now)
                
                for record in records {
                    print("시간: \(record.date), 커피: \(record.beverage.name), 사이즈: \(record.size.name), 양: \(record.beverage.franchise.getSizeAmount(size: record.size.name)), 추가 샷 수: \(record.addedShotCount), 카페인 양: \(intakeManager.getCaffeineAmount(record: record))")
                }
            }) {
                Text("오늘 섭취 기록 보기")
            }
            
            Button(action: {
                print("[최근 기록]")
                
                let records = intakeManager.getRecentRecords(count: 6)
                for record in records {
                    print("시간: \(record.date), 커피: \(record.beverage.name), 사이즈: \(record.size.name), 양: \(record.beverage.franchise.getSizeAmount(size: record.size.name)), 추가 샷 수: \(record.addedShotCount), 카페인 양: \(intakeManager.getCaffeineAmount(record: record))")
                }
            }) {
                Text("최근 기록 불러오기")
            }

            Button(action: {
                print("[부작용 추가]")
                
                sideEffectManager.addRecord(date: Date.now,
                                                  sideEffects: [
                                                    SideEffect.allCases[index % 10],
                                                    SideEffect.allCases[(index + 1) % 10],
                                                    SideEffect.allCases[(index + 2) % 10],
                                                  ])

                let addedSideEffect = sideEffectManager.getAllRecords()[sideEffectManager.getAllRecords().count - 1].sideEffects
                
                for sideEffect in addedSideEffect {
                    print(sideEffect.getSideEffectName(), terminator: " ")
                }
                print("")

                index += 1
            }) {
                Text("부작용 추가하기")
            }

            Button(action: {
                print("[오늘 부작용]")
                let dailySideEffects = sideEffectManager.getDailyRecords(date: Date.now)

                for sideEffect in dailySideEffects {
                    print(sideEffect.getSideEffectName())
                }
            }) {
                Text("오늘 부작용 보기")
            }

            TextField("Beverage Name", text: $beverageName)
                .textFieldStyle(.roundedBorder)
                .padding()

            Button(action: {
                print("[검색 결과]")
                let beverage = beverageManager.getBeverage(name: beverageName, franchise: .starbucks)
                
                guard let beverage = beverage else {
                    print("No Drink")
                    return
                }
                
                print(beverage.name + ", sizes: ", terminator: "")
                for size in beverage.sizeInfo {
                    print(size.name, terminator: " ")
                }
                print("")
            }) {
                Text("음료 검색하기")
            }

            Button(action: {
                print("[오늘 마신 카페인 양]")
                print(intakeManager.getTodayIntakeCaffeineAmount())
            }) {
                Text("오늘 카페인 섭취량")
            }
            
            Button(action: {
                print("[잔존량]")
                print(Int(intakeManager.getRemainCaffeineAmount()))
                
                let time = intakeManager.getRemainTimeToDischarge()
                let hours = time / 3600
                let minutes = (time % 3600) / 60
                let seconds = time % 60
                print("[배출까지 남은 시간")
                print("[\(String(format: "%02d", hours)):\(String(format: "%02d", minutes)):\(String(format: "%02d", seconds))]")
            }) {
                Text("잔존량 & 배출까지 남은 시간")
            }
        }
    }
}

struct TestView_P_Previews: PreviewProvider {
    static var previews: some View {
        TestView_P()
    }
}

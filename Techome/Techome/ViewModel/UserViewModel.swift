//
//  UserViewModel.swift
//  Techome
//
//  Created by Yeongwoo Kim on 2022/06/09.
//

import Foundation

typealias SizeIndex = Int

class UserViewModel: ObservableObject{
    @Published var drinkRecords: [DrinkRecord] = []
    @Published var sideEffectRecords: [SideEffectRecord] = []
    let dateTimeFormatter = DateFormatter()
    let dateFormatter = DateFormatter()
    
    init(){
        dateTimeFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.dateFormat = "yyyy-MM-dd"
    }
    
    //TODO: 카페인 체내 잔존량을 반환하는 함수
    func getRemainCaffeine() -> Int{
        return 0
    }
    
    //오늘 카페인 섭취량을 반환하는 함수
    func getTodayCaffeineAmount() -> Int{
        var drinkCaffeineAmount = 0
        let todayDrinkRecords = getDailyDrinkRecords(date: Date.now)
        
        for record in todayDrinkRecords{
            drinkCaffeineAmount += record.drink.caffeineAmount
        }
        
        return drinkCaffeineAmount
    }
    
    //TODO: 체내 카페인 배출 시간을 분 단위로 반환하는 함수
    func getTimeToDischargeCaffeine(amount: Int) -> Int{
        return 0
    }
    
    //해당 이름의 프렌차이즈 음료를 반환하는 함수
    func getDrink(datas: [DrinkData], name: String, franchise: Franchise) -> DrinkData?{
        for data in datas{
            if data.franchise == franchise && data.name == name{
                return data
            }
        }
        
        return nil
    }
    
    //음료 기록 저장
    func addDrinkRecord(drinkData: DrinkData, sizeIndex: SizeIndex){
        self.drinkRecords.append(DrinkRecord(date: Date.now,
                                        drink: Drink(name: drinkData.name,
                                                     franchise: drinkData.franchise,
                                                     caffeineAmount: drinkData.caffeineAmount[sizeIndex],
                                                     addedShotCount: 0)))
        
        do{
            try JSONManager.save(data: drinkRecords, filename: "DrinkRecord")
        }catch{
            fatalError("Drink Record Save Error")
        }
        
    }
    
    //부작용 기록 저장
    func addSideEffectRecord(date: Date, sideEffect: [SideEffect]){
        self.sideEffectRecords.append(SideEffectRecord(date: date,
                                                       sideEffect: sideEffect))
    }
    
    //해당 날짜의 음료 기록 반환
    func getDailyDrinkRecords(date: Date) -> [DrinkRecord]{
        var dailyDrinkRecords: [DrinkRecord] = []
        
        for record in drinkRecords{
            if dateFormatter.string(from: record.date) == dateFormatter.string(from: date){
                dailyDrinkRecords.append(record)
            }
        }
        
        return dailyDrinkRecords
    }
    
    //해당 날짜의 부작용 기록 반환
    func getDailySideEffectRecords(date: Date) -> [SideEffectRecord]{
        var dailySideEffectRecord: [SideEffectRecord] = []
        
        for record in sideEffectRecords{
            if dateFormatter.string(from: record.date) == dateFormatter.string(from: date){
                dailySideEffectRecord.append(record)
            }
        }
        
        return dailySideEffectRecord
    }
    
    //TODO: 모든 기록 반환
    func getAllRecords() -> [Any]{
        var records: [Any] = drinkRecords
        records += sideEffectRecords
        
        return []
    }
}

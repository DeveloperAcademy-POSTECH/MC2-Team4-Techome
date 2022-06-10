//
//  ContentView.swift
//  Techome
//
//  Created by Noah Park on 2022/06/09.
//

import SwiftUI

struct ContentView: View {
    let intakeRecordManager = IntakeRecordManager.shared
    let sideEffectRecordManager = SideEffectRecordManager.shared
    
    @State var dummyDatas: [Beverage]?
    @State var index = 0
    
    @State var beverageName = ""
    
    var body: some View {
        VStack{
            Button(action: {
                do {
                    try JSONManager.shared.store(data: beverageDatas, filename: "BeverageData.json")
                } catch {
                    fatalError("store errors")
                }

            }) {
                Text("Make Json File")
            }

            Button(action: {
                do {
                    dummyDatas = try JSONManager.shared.load(filename: "BeverageData.json")
                } catch {
                    fatalError("load errors")
                }
            }) {
                Text("Load Json File")
            }

            Button(action: {
                if let data = dummyDatas {
                    intakeRecordManager.addRecord(beverage: data[index], sizeIndex: index%3)
                }
                index+=1
            }) {
                Text("Add Beverage Record")
            }

            Button(action: {
                print(beverageRecords)
            }) {
                Text("Print Beverage Recordes")
            }
            
            Button(action: {
                let beverage = beverageRecords[0].beverage
                
                print(beverage.franchise.getSizeAmount(size: beverage.size))
            }) {
                Text("Print Size Of Beverage")
            }

            Button(action: {
                sideEffectRecordManager.addRecord(date: Date.now,
                                                  sideEffect: [.dehydration, .depression, .insomnia])

                let addedSideEffect = sideEffectRecords[sideEffectRecords.count - 1].sideEffect
                for sideEffect in addedSideEffect {
                    print(sideEffect.getSideEffectName(), terminator: " ")
                }
                print("")

            }) {
                Text("Add Side Effect")
            }

            Button(action: {
                print(intakeRecordManager.getDailyRecords(date: Formatter.date.date(from: "2022-06-10")!))
            }) {
                Text("Get Today Beverage")
            }

            Button(action: {
                let dailySideEffectRecords = sideEffectRecordManager.getDailyRecords(date: Formatter.date.date(from: "2022-06-10")!)

                for dailyRecords in dailySideEffectRecords {
                    let records = dailyRecords.sideEffect

                    for record in records {
                        print(record.getImageName() + "\t" + record.getSideEffectName())
                    }
                }
            }) {
                Text("Get Today SideEffect")
            }
            
            Button(action: {
                for sideEffect in SideEffect.allCases{
                    print(sideEffect.getSideEffectName() + " : " + sideEffect.getImageName())
                }
            }) {
                Text("Print All Side Effects")
            }

//            TextField("Beverage Name", text: $beverageName)

//            Button(action: {
//                if let datas = dummyDatas {
//                    let beverageData: BeverageData? = user.getBeverage(datas: datas, name: beverageName, franchise: Franchise.starbucks)
//
//                    if let data = beverageData {
//                        print(data)
//                    } else {
//                        print("No Drink")
//                    }
//                }
//            }) {
//                Text("Get beverageData")
//            }

//            Button(action: {
//                print(intakeRecordManager.getTodayCaffeineAmount())
//            }) {
//                Text("Get Today Caffeine Amount")
//            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

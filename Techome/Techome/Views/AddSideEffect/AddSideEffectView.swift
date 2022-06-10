//
//  AddSideEffect.swift
//  Techome
//
//  Created by 김유나 on 2022/06/10.
//

import SwiftUI

struct AddSideEffect: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var sideEffectDate = Date()
    @State private var showDatePicker = false
    @State private var showHourAndMinutePicker = false
    @State private var isSelected: [Bool] = [false, false, false, false, false, false, false, false, false, false]
    
    let navigationBarBottomPadding: CGFloat = 70
    let navigationBarHorizontalPadding: CGFloat = 19
    let contentHorizontalPadding: CGFloat = 15
    let labelBottomPadding: CGFloat = 15
    let contentBetweenPadding: CGFloat = 31
    
    let columns = [
        GridItem(.adaptive(minimum: 172)),
        GridItem(.adaptive(minimum: 172))
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                
                Color.backgroundCream.edgesIgnoringSafeArea(.all)
                
                VStack(alignment: .leading, spacing: 0) {
                    
                    Group {
                        Text("언제 부작용을 겪으셨나요?")
                            .foregroundColor(.secondaryTextGray)
                            .font(.subheadline)
                            .padding(.bottom, labelBottomPadding)
                        
                        HStack {
                            DatePicker("부작용 일시", selection: $sideEffectDate, in: ...Date(), displayedComponents: [.date])
                                .fixedSize()
                                .frame(width: 117)
                            
                            DatePicker("부작용 일시", selection: $sideEffectDate, in: ...Date(), displayedComponents: [.hourAndMinute])
                                .fixedSize()
                                .frame(width: 97)
                        }
                        .labelsHidden()
                        .accentColor(.primaryBrown)
                        .padding(.bottom, contentBetweenPadding)
                        
                        Text("어떤 부작용을 겪으셨나요?")
                            .foregroundColor(.secondaryTextGray)
                            .font(.subheadline)
                            .padding(.bottom, labelBottomPadding)
                        
                    } // Group
                    .padding(.horizontal, contentHorizontalPadding)
                    
                    LazyVGrid(columns: columns, spacing: 15) {
                        ForEach(sideEffects, id: \.self) { sideEffect in
                            ZStack {
                                RoundedRectangle(cornerRadius: 5)
                                    .foregroundColor(.white)
                                //                                    .foregroundColor(isSelected[idx] ? .brown : .white)
                                    .shadow(color: .primaryShadowGray, radius: 2, x: 0, y: 0)
                                
                                HStack(spacing: 0) {
                                    Image("heartburn")
                                        .renderingMode(.template)
                                        .fixedSize()
                                        .foregroundColor(.customBlack)
                                        .frame(width: 20, alignment: .center)
                                    
                                    Text(sideEffect)
                                        .padding(.vertical, 12.5)
                                        .font(.body)
                                        .fixedSize()
                                        .frame(width: 66, alignment: .center)
                                        .padding(.leading, 18)
                                }
                                .padding(.horizontal)
                            }
                            .onTapGesture {
                                print("두근거림")
                            }
                            
                        }
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                    
                } // VStack
                .padding(.top, 57)
            }
            .navigationTitle("부작용 추가하기")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("취소")
                            .foregroundColor(.primaryBrown)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        print("저장 누름")
                    }) {
                        Text("저장")
                            .foregroundColor(.primaryBrown)
                    }
                }
            }
        }
    }
}

struct AddSideEffect_Previews: PreviewProvider {
    static var previews: some View {
        AddSideEffect()
    }
}

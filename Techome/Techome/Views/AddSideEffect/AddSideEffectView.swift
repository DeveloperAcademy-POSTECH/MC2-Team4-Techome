//
//  AddSideEffect.swift
//  Techome
//
//  Created by 김유나 on 2022/06/10.
//

import SwiftUI

struct AddSideEffectLayoutValue {
    
    // AddSideEffectView Paddings
    struct Paddings {
        static let contentHorizontalPadding: CGFloat = 15
        static let contentBetweenVerticalPadding: CGFloat = 31
        static let labelBottomPadding: CGFloat = 15
        static let gridItemHorizantalPadding: CGFloat = 15
        static let gridTextVerticalPadding: CGFloat = 12.5
        static let gridImageTextPadding: CGFloat = 18
    }
    
    // AddSideEffectView Sizes
    struct Sizes {
        static let sideEffectImageWidth: CGFloat = 20
        static let gridImageTextWidth: CGFloat = 66
    }
    
    // AddSideEffectView Radius
    struct Radius {
        static let buttonRadius: CGFloat = 5
    }
}

struct AddSideEffectView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var sideEffectDate = Date()
    @State private var isSelected: [Bool] = [false, false, false, false, false, false, false, false, false, false]
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.backgroundCream.edgesIgnoringSafeArea(.all)
                
                VStack(alignment: .leading, spacing: 0) {
                    
                    Text("언제 부작용을 겪으셨나요?")
                        .foregroundColor(.secondaryTextGray)
                        .font(.subheadline)
                        .padding(.top, AddSideEffectLayoutValue.Paddings.contentBetweenVerticalPadding)
                        .padding(.bottom, AddSideEffectLayoutValue.Paddings.labelBottomPadding)
                    
                    DatePicker("부작용 일시", selection: $sideEffectDate, in: ...Date())
                        .labelsHidden()
                        .accentColor(.primaryBrown)
                        .frame(alignment: .leading)
                        .padding(.bottom, AddSideEffectLayoutValue.Paddings.contentBetweenVerticalPadding)
                    
                    Text("어떤 부작용을 겪으셨나요?")
                        .foregroundColor(.secondaryTextGray)
                        .font(.subheadline)
                        .padding(.bottom, AddSideEffectLayoutValue.Paddings.labelBottomPadding)
                    
                    LazyVGrid(columns: columns, spacing: AddSideEffectLayoutValue.Paddings.gridItemHorizantalPadding) {
                        
                        ForEach(sideEffects.indices, id: \.self) { sideEffect in
                            ZStack {
                                
                                RoundedRectangle(cornerRadius: AddSideEffectLayoutValue.Radius.buttonRadius)
                                    .foregroundColor(isSelected[sideEffect] ? .primaryBrown : .white)
                                    .shadow(color: .primaryShadowGray, radius: 2, x: 0, y: 0)
                                
                                HStack(spacing: 0) {
                                    Image("heartburn")
                                        .renderingMode(.template)
                                        .fixedSize()
                                        .frame(width: AddSideEffectLayoutValue.Sizes.sideEffectImageWidth, alignment: .center)
                                    
                                    Text(sideEffects[sideEffect])
                                        .padding(.vertical, AddSideEffectLayoutValue.Paddings.gridTextVerticalPadding)
                                        .padding(.leading, AddSideEffectLayoutValue.Paddings.gridImageTextPadding)
                                        .font(.body)
                                        .fixedSize()
                                        .frame(width: AddSideEffectLayoutValue.Sizes.gridImageTextWidth, alignment: .center)
                                    
                                } // HStack
                                .padding(.horizontal)
                                .foregroundColor(isSelected[sideEffect] ? .white : .customBlack)
                                
                            } // ZStack
                            .onTapGesture {
                                isSelected[sideEffect].toggle()
                            }
                        } // ForEach
                        
                    } // LazyVGrid
                    
                    Spacer()
                    
                } // VStack
                .padding(.horizontal, AddSideEffectLayoutValue.Paddings.contentHorizontalPadding)
            }
            .navigationTitle("부작용 추가하기")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading:
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("취소")
                        .foregroundColor(.primaryBrown)
                })
            .navigationBarItems(trailing:
                Button(action: {
                    // run 저장(update) method
                    self.presentationMode.wrappedValue.dismiss()
            }) {
                Text("저장")
                    .foregroundColor(.primaryBrown)
            })
        }
    }
}

struct AddSideEffect_Previews: PreviewProvider {
    static var previews: some View {
        AddSideEffectView()
    }
}

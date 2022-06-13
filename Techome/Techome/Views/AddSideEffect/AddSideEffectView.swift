//
//  AddSideEffect.swift
//  Techome
//
//  Created by 김유나 on 2022/06/10.
//

import SwiftUI

struct AddSideEffectLayoutValue {
    
    struct Paddings {
        static let contentHorizontalPadding: CGFloat = 15
        static let contentBetweenVerticalPadding: CGFloat = 31
        static let labelBottomPadding: CGFloat = 15
        static let gridItemHorizantalPadding: CGFloat = 15
        static let gridTextVerticalPadding: CGFloat = 12.5
        static let gridImageTextPadding: CGFloat = 18
        static let sideEffectColumnSpacing: CGFloat = 16
        static let sideEffectRowSpacing: CGFloat = 15
    }
    
    struct Sizes {
        static let sideEffectImageWidth: CGFloat = 20
        static let gridTextWidth: CGFloat = 66
        static let sideEffectButtonHeight: CGFloat = 47
    }
    
    struct Radius {
        static let buttonRadius: CGFloat = 5
        static let buttonShadowRadius: CGFloat = 2
    }
    
    struct Grid {
        static let sideEffectTypeColumnCount: Int = 2
        static let sideEffectTypeRowCount: Int = 5
    }
}

struct AddSideEffectView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        NavigationView {
            ZStack {
                Color.backgroundCream.edgesIgnoringSafeArea(.all)
                
                VStack(alignment: .leading, spacing: .zero) {
                    SideEffectDate()
                    SideEffectType()
                    Spacer()
                }
                .padding(.horizontal, AddSideEffectLayoutValue.Paddings.contentHorizontalPadding)
            }
            .navigationTitle("부작용 추가하기")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading: Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("취소")
                        .foregroundColor(.primaryBrown)
                },
                trailing: Button(action: {
                    //TODO: run 저장(update) method
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("저장")
                        .foregroundColor(.primaryBrown)
                }
            )
        }
    }
}

struct SideEffectDate: View {
    
    @EnvironmentObject var sideEffectStates: AddSideEffectStateHolder
    
    var body: some View {
        Text("언제 부작용을 겪으셨나요?")
            .foregroundColor(.secondaryTextGray)
            .font(.subheadline)
            .padding(.top, AddSideEffectLayoutValue.Paddings.contentBetweenVerticalPadding)
            .padding(.bottom, AddSideEffectLayoutValue.Paddings.labelBottomPadding)
        
        DatePicker("부작용 일시", selection: $sideEffectStates.sideEffectDate, in: ...Date())
            .labelsHidden()
            .accentColor(.primaryBrown)
            .frame(alignment: .leading)
            .padding(.bottom, AddSideEffectLayoutValue.Paddings.contentBetweenVerticalPadding)
    }
}

struct SideEffectType: View {
    
    var body: some View {
        
        Text("어떤 부작용을 겪으셨나요?")
            .foregroundColor(.secondaryTextGray)
            .font(.subheadline)
            .padding(.bottom, AddSideEffectLayoutValue.Paddings.labelBottomPadding)
                
        HStack(spacing: AddSideEffectLayoutValue.Paddings.sideEffectColumnSpacing) {
            ForEach(0 ..< AddSideEffectLayoutValue.Grid.sideEffectTypeColumnCount, id: \.self) { sideEffectColumnIndex in
                VStack(spacing: AddSideEffectLayoutValue.Paddings.sideEffectRowSpacing) {
                    ForEach(0 ..< AddSideEffectLayoutValue.Grid.sideEffectTypeRowCount, id: \.self) { sideEffectRowIndex in
                        SideEffectButton(sideEffectIndex: sideEffectRowIndex * 2 + sideEffectColumnIndex)
                    }
                }
            }
        }
    }
}

struct SideEffectButton: View {
        
    @EnvironmentObject var sideEffectStates: AddSideEffectStateHolder
    
    var sideEffectIndex: Int
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: AddSideEffectLayoutValue.Radius.buttonRadius)
                .foregroundColor(sideEffectStates.isSelected[sideEffectIndex] ? .primaryBrown : .white)
                .shadow(color: .primaryShadowGray, radius: AddSideEffectLayoutValue.Radius.buttonShadowRadius, x: .zero, y: .zero)
            
            HStack(spacing: .zero) {
                Image("heartburn")
                    .renderingMode(.template)
                    .fixedSize()
                    .frame(width: AddSideEffectLayoutValue.Sizes.sideEffectImageWidth, alignment: .center)
                
                Text("tempString"/*sideEffects[sideEffectIndex]*/)
                    .font(.body)
                    .padding(.leading, AddSideEffectLayoutValue.Paddings.gridImageTextPadding)
                    .fixedSize()
                    .frame(width: AddSideEffectLayoutValue.Sizes.gridTextWidth, alignment: .center)
            }
            .padding(.horizontal)
            .foregroundColor(sideEffectStates.isSelected[sideEffectIndex] ? .white : .customBlack)
        }
        .frame(height: AddSideEffectLayoutValue.Sizes.sideEffectButtonHeight)
        .onTapGesture {
//            isSelected[sideEffectIndex].toggle()
            sideEffectStates.onButtonTouched(sideEffectIndex: sideEffectIndex)
        }
    }
}

struct AddSideEffect_Previews: PreviewProvider {
    static var previews: some View {
        let sideEffectStates = AddSideEffectStateHolder()
        
        AddSideEffectView()
            .environmentObject(sideEffectStates)
    }
}

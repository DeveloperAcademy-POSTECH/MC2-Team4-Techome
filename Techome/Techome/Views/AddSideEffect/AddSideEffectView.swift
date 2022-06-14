//
//  AddSideEffect.swift
//  Techome
//
//  Created by 김유나 on 2022/06/10.
//

import SwiftUI

struct AddSideEffectLayoutValue {
    
    struct Padding {
        static let contentHorizontal: CGFloat = 15
        static let contentBetweenVertical: CGFloat = 31
        static let labelBottom: CGFloat = 15
        static let gridImageText: CGFloat = 18
        static let gridColumnSpacing: CGFloat = 16
        static let gridRowSpacing: CGFloat = 15
    }
    
    struct Size {
        static let sideEffectImageWidth: CGFloat = 20
        static let gridTextWidth: CGFloat = 66
        static let sideEffectButtonHeight: CGFloat = 47
    }
    
    struct Radius {
        static let button: CGFloat = 5
        static let buttonShadow: CGFloat = 2
    }
    
    struct Grid {
        static let columnCount: Int = 2
        static let rowCount: Int = 5
    }
}

struct AddSideEffectView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var sideEffectStates: AddSideEffectStateHolder
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.backgroundCream.edgesIgnoringSafeArea(.all)
                
                VStack(alignment: .leading, spacing: .zero) {
                    SideEffectDate()
                    SideEffectType()
                    Spacer()
                }
                .padding(.horizontal, AddSideEffectLayoutValue.Padding.contentHorizontal)
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
                    sideEffectStates.onSavedPressed()
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("저장")
                        .foregroundColor(sideEffectStates.isDisabled ? .secondaryTextGray : .primaryBrown)
                }
                    .disabled(sideEffectStates.isDisabled)
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
            .padding(.top, AddSideEffectLayoutValue.Padding.contentBetweenVertical)
            .padding(.bottom, AddSideEffectLayoutValue.Padding.labelBottom)
        
        DatePicker("부작용 일시", selection: $sideEffectStates.sideEffectDate, in: ...Date())
            .labelsHidden()
            .accentColor(.primaryBrown)
            .frame(alignment: .leading)
            .padding(.bottom, AddSideEffectLayoutValue.Padding.contentBetweenVertical)
    }
}

struct SideEffectType: View {
    
    var body: some View {
        
        Text("어떤 부작용을 겪으셨나요?")
            .foregroundColor(.secondaryTextGray)
            .font(.subheadline)
            .padding(.bottom, AddSideEffectLayoutValue.Padding.labelBottom)
                
        HStack(spacing: AddSideEffectLayoutValue.Padding.gridColumnSpacing) {
            ForEach(0 ..< AddSideEffectLayoutValue.Grid.columnCount, id: \.self) { sideEffectColumnIndex in
                VStack(spacing: AddSideEffectLayoutValue.Padding.gridRowSpacing) {
                    ForEach(0 ..< AddSideEffectLayoutValue.Grid.rowCount, id: \.self) { sideEffectRowIndex in
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
            RoundedRectangle(cornerRadius: AddSideEffectLayoutValue.Radius.button)
                .foregroundColor(sideEffectStates.isSelected[sideEffectIndex] ? .primaryBrown : .white)
                .shadow(color: .primaryShadowGray, radius: AddSideEffectLayoutValue.Radius.buttonShadow, x: .zero, y: .zero)
            
            HStack(spacing: .zero) {
                Image(sideEffectStates.totalSideEffectList[sideEffectIndex].getImageName())
                    .renderingMode(.template)
                    .fixedSize()
                    .frame(width: AddSideEffectLayoutValue.Size.sideEffectImageWidth, alignment: .center)
                
                Text(sideEffectStates.totalSideEffectList[sideEffectIndex].getSideEffectName())
                    .font(.body)
                    .padding(.leading, AddSideEffectLayoutValue.Padding.gridImageText)
                    .fixedSize()
                    .frame(width: AddSideEffectLayoutValue.Size.gridTextWidth, alignment: .center)
            }
            .padding(.horizontal)
            .foregroundColor(sideEffectStates.isSelected[sideEffectIndex] ? .white : .customBlack)
        }
        .frame(height: AddSideEffectLayoutValue.Size.sideEffectButtonHeight)
        .onTapGesture {
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

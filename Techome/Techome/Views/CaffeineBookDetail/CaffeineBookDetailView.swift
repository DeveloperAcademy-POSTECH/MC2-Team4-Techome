//
//  CaffeineBookDetailView.swift
//  Techome
//
//  Created by 김유나 on 2022/06/14.
//

import SwiftUI

struct CaffeineBookDetailView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color.backgroundCream.edgesIgnoringSafeArea(.all)
                
                VStack {
                    VStack(alignment: .center, spacing: .zero) {
                        Text("아메리카노")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.customBlack)
                            .padding(.top, 43)
                        
                        Text("스타벅스")
                            .font(.caption)
                            .foregroundColor(.secondaryTextGray)
                            .padding(.top, 8)
                        
                        HStack(spacing: 21) {
                            RoundedRectangle(cornerRadius: 5)
                                .frame(width: 92, height: 98)
                                .foregroundColor(.primaryBrown)
                                .shadow(color: Color.secondaryShadowGray, radius: 4, x: 0, y: 0)
                                .overlay(
                                    VStack(spacing: 0) {
                                        Text("Tall")
                                            .font(.title2)
                                        Text("355ml")
                                            .padding(.top, 12)
                                            .font(.caption)
                                            .foregroundColor(.secondaryTextGray)
                                    }
                                        .foregroundColor(.white)
                                )
                                .onTapGesture {
                                    print("Tall 누름")
                                }
                            RoundedRectangle(cornerRadius: 5)
                                .frame(width: 92, height: 98)
                                .foregroundColor(.white)
                                .shadow(color: Color.primaryShadowGray, radius: 2, x: 0, y: 0)
                                .overlay(
                                    VStack(spacing: 0) {
                                        Text("Tall")
                                            .font(.title2)
                                        Text("355ml")
                                            .padding(.top, 12)
                                            .font(.caption)
                                            .foregroundColor(.secondaryTextGray)
                                    })
                                .foregroundColor(.customBlack)
                                .onTapGesture {
                                    print("Tall 누름")
                                }
                            RoundedRectangle(cornerRadius: 5)
                                .frame(width: 92, height: 98)
                                .foregroundColor(.white)
                                .shadow(color: Color.primaryShadowGray, radius: 2, x: 0, y: 0)
                                .overlay(
                                    VStack(spacing: 0) {
                                        Text("Tall")
                                            .font(.title2)
                                        Text("355ml")
                                            .padding(.top, 12)
                                            .font(.caption)
                                            .foregroundColor(.secondaryTextGray)
                                    })
                                .foregroundColor(.customBlack)
                                .onTapGesture {
                                    print("Tall 누름")
                                }
                        }
                        .padding(.top, 38)
                        .padding(.bottom, 6)
                        Group {
                            HStack {
                                Text("샷 수")
                                    .font(.title3)
                                    .foregroundColor(.customBlack)
                                Spacer()
                                Text("2샷")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.primaryBrown)
                            }
                            .padding(.top, 40)
                            HStack {
                                Text("카페인")
                                    .font(.title3)
                                    .foregroundColor(.customBlack)
                                Spacer()
                                Text("175mg")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.primaryBrown)
                            }
                            .padding(.top, 40)
                            HStack {
                                Spacer()
                                Text("하루 권장량 400mg")
                                    .padding(.top, 5)
                                    .font(.caption)
                                    .foregroundColor(.secondaryTextGray)
                            }
                            HStack {
                                Text("배출")
                                    .font(.title3)
                                    .foregroundColor(.customBlack)
                                Spacer()
                                Text("2시간 45분")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.primaryBrown)
                            }
                            .padding(.top, 19)
                            .padding(.bottom, 38)
                            
                        }
                        .padding(.horizontal, 19)
                    }
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.horizontal, 15)
                    .padding(.top, 15)
                    .shadow(color: Color.primaryShadowGray, radius: 4, x: 0, y: 0)
                    
                    Spacer()
                }
            }
            .navigationTitle("카페인 찾아보기")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading: Button(action: {
                    print("뒤로가기")
                }) {
                    Image(systemName: "chevron.left")
                        .font(.headline)
                        .foregroundColor(.primaryBrown)
                }
            )
        }
    }
}


struct CaffeineBookDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CaffeineBookDetailView()
    }
}

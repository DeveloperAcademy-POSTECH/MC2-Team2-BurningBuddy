//
//  ModeSelectionView.swift
//  BurningBuddy
//
//  Created by Bokyung on 2023/09/22.
//

import SwiftUI

// 유저가 1인 플레이를 할지, 2인 플레이를 할지 선택하는 뷰입니다.
struct ModeSelectionView: View {
    @ObservedObject var userModel: UserModel
    @ObservedObject var bunnyModel: BunnyModel
    @ObservedObject var workoutModel: WorkoutModel
    @ObservedObject var healthData = HealthData()
    
    @State var isModeSelected: Bool = false // 모드를 선택했는지(버튼이 한번이라도 눌렸는지)
    @State var isSingleMode: Bool = true // sigle모드인지
    @State var showEvolution = false // 진화과정 모달에 관련된 상태
    
    @State var mainViewNavLinkActive: Bool = false
    
    var body: some View {
        VStack (spacing: 0){
            HStack (alignment: .top, spacing: 0){
                Text("원하는 모드를 \n선택해주세요")
                    .font(.system(size: 28, weight: .bold))
                Spacer()
                
                
                Button(action: {
                    self.showEvolution = true
                    print("showEvolution click")
                }, label: {
                    Image(systemName: "info.circle")
                        .resizable()
                        .foregroundColor(Color.iconColor)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30)
                })
                .fullScreenCover(isPresented: self.$showEvolution, content: {
                    LevelUpModalView(userModel: userModel, bunnyModel: bunnyModel)
                })
                .foregroundColor(Color.iconColor)
            } // HStack
            
            Spacer()
            
            HStack (spacing: 19){
                Button(action: {
                    isSingleMode = true
                    isModeSelected = true
                }, label: {
                    VStack (spacing: 24){
                        
                        Text("👤")
                            .font(.system(size: 24))
                        Text("1인 모드")
                            .font(.system(size: 24, weight: .semibold))
                            .foregroundColor(isModeSelected && isSingleMode ? Color.bunnyColor : Color.white)
                    } // VStack
                    .padding(.vertical, 38.5)
                    .frame(maxWidth: .infinity)
                    .background(isModeSelected && isSingleMode ? Color.bunnyColor.opacity(0.1).cornerRadius(16) :  Color.mainSection3.cornerRadius(16))
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(isModeSelected && isSingleMode ? Color.bunnyColor.opacity(1) : Color.bunnyColor.opacity(0), lineWidth: 3)
                    )
                    
                })
                
                Button(action: {
                    isSingleMode = false
                    isModeSelected = true
                }, label: {
                    VStack (spacing: 24){
                        Text("👥")
                            .font(.system(size: 24))
                        Text("2인 모드")
                            .font(.system(size: 24, weight: .semibold))
                            .foregroundColor(isModeSelected && !isSingleMode ? Color.bunnyColor : Color.white)
                    }
                    .padding(.vertical, 38.5)
                    .frame(maxWidth: .infinity)
                    .background(isModeSelected && !isSingleMode ? Color.bunnyColor.opacity(0.1).cornerRadius(16) :  Color.mainSection3.cornerRadius(16))
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(isModeSelected && !isSingleMode ? Color.bunnyColor.opacity(1) : Color.bunnyColor.opacity(0), lineWidth: 3)
                    )
                })
            }
            
            Spacer()
            
            NavigationLink(
                destination: isSingleMode ? AnyView(SingleWorkoutView(userModel: userModel, bunnyModel: bunnyModel, workoutModel: workoutModel, healthData: healthData, mainViewNavLinkActive: $mainViewNavLinkActive)) : AnyView(SearchPartnerView(userModel: userModel, bunnyModel: bunnyModel, workoutModel: workoutModel, healthData: healthData, mainViewNavLinkActive: $mainViewNavLinkActive)),
                label: {
                    Text("운동 시작하기")
                }
            )
            .buttonStyle(RedButtonStyle2(fontSize: 18, isModeSelected: $isModeSelected))
            .disabled(!isModeSelected) // 버튼을 비활성화
            
        } // VStack
        .padding(.top, 20)
        .padding(.bottom, 15)
        .padding(.horizontal, 24)
        .background(Color.backgroundColor)
        .navigationBarTitle("")
        
        //.padding(.horizontal, 24)
        
        
    }
}

#Preview {
    NavigationView {
        ModeSelectionView(userModel: UserModel(), bunnyModel: BunnyModel(), workoutModel: WorkoutModel())
    }
}

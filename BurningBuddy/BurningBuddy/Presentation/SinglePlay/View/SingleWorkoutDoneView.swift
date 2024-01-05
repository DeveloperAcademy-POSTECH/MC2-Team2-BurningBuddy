//
//  SingleWorkoutDoneView.swift
//  BurningBuddy
//
//  Created by Bokyung on 2023/09/30.
//

import SwiftUI

/**
 파트너의 데이터모델을 들고 오는 것이 필요.
 만약 데이터가 없거나, 목표 달성을 하지 못한 것이 감지되는 경우,
 MissionModal을 띄워줘야 한다. 이 로직은 목표달성 확인하기 button action에서 해야 한다.
 단, 길어질 경우, 새로운 메서드 안에서 이 과정을 실행해야 한다.
 
 isDoneTogetherWorkout 변수를 settings에서 달성 여부를 판단해서 가지고 있어야 한다.
 
 */
struct SingleWorkoutDoneView: View {
    @ObservedObject var userModel: UserModel
    @ObservedObject var bunnyModel: BunnyModel
    @ObservedObject var workoutModel: WorkoutModel
    
    @State var isNotDoneWorkoutPopup = false
    @State private var isSuccessNext: Bool = false
    @Binding var mainViewNavLinkActive: Bool
    
    @StateObject private var niObject = NISessionManager()
    @State private var isLaunched = true
    @State var isLocalNetworkPermissionDenied = false
    @State private var checkPartner: Bool = false
    @State var isDataReceived: Bool = false
    private let localNetAuth = LocalNetworkAuthorization()
    
    
    var body: some View {
        VStack {
            AnyView(setTitleText()) // 타이틀, 텍스트
            Spacer()
            Image(systemName: "hands.sparkles.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 189)
                .foregroundColor(Color.bunnyColor)
            Spacer()
            
            NavigationLink(isActive: $isSuccessNext, destination: {
                if UserDefaults.standard.bool(forKey: "isDoneWorkout") {
                    WorkoutSuccessView(userModel: userModel, bunnyModel: bunnyModel, workoutModel: workoutModel, mainViewNavLinkActive: $mainViewNavLinkActive)
                } else {
                    WorkoutFailView(userModel: userModel, bunnyModel: bunnyModel, workoutModel: workoutModel, mainViewNavLinkActive: $mainViewNavLinkActive)
                }
            }, label: {
                Button("목표달성 확인하기") {
                    if UserDefaults.standard.bool(forKey: "isDoneWorkout") {
//                        UserDefaults.standard.set(true, forKey: "isDoneTogetherWorkout")
                        print("1인 기능 - 목표를 달성했어요!")
                        isNotDoneWorkoutPopup = false
                        isSuccessNext = true // TODO: 다음 페이지로 넘어가야 함
                        
                    } else {
                        UserDefaults.standard.set(false, forKey: "isDoneTogetherWorkout")
                        isNotDoneWorkoutPopup = true
                    }
                }
                .buttonStyle(BurningBuddyButton(style: .red))
            })
        } // VStack
        .padding(EdgeInsets(top: 50, leading: 30, bottom: 15, trailing: 30)) // 전체 아웃라인
        .background(Color(red: 30/255, green: 28/255, blue: 29/255))
        .navigationBarHidden(true)
    } // body End
}

extension SingleWorkoutDoneView {
    // 운동 완료화면의 상단 text -> {}님, 수고하셨어요! 🥇
    private func setTitleText() -> any View {
        VStack {
            Text("\(userModel.userName)님,")
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.white)
                .font(.system(size: 21, weight: .bold))
            Text("수고하셨어요! 🥇")
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.white)
                .font(.system(size: 28, weight: .bold))
            Text("애플워치 운동기록을 종료하신 후,\n목표달성 여부를 확인해보세요")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(EdgeInsets(top: 1, leading: 0, bottom: 0, trailing: 0))
                .font(.system(size: 17, weight: .regular, design: .default))
                .lineSpacing(TextUtil().calculateLineSpacing(17, 143.5))
        }
    }
}


#Preview {
    SingleWorkoutDoneView(userModel: UserModel(), bunnyModel: BunnyModel(), workoutModel: WorkoutModel(), mainViewNavLinkActive: .constant(true))
}

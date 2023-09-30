//
//  SingleWorkoutView.swift
//  BurningBuddy
//
//  Created by Bokyung on 2023/09/30.
//

import SwiftUI

// 유저 혼자 운동을 할때 운동 중을 보여주는 뷰입니다. 
struct SingleWorkoutView: View {
    @ObservedObject var userModel: UserModel
    @ObservedObject var bunnyModel: BunnyModel
    @ObservedObject var workoutModel: WorkoutModel
    @ObservedObject var healthData: HealthData
    
    @State private var isNotDoneWorkout: Bool = false
    @State var isNextButtonTapped: Bool = false
    @Binding var mainViewNavLinkActive: Bool
    
    var body: some View {
        VStack {
            HStack {
                Text(userModel.userName)
                    .font(.system(size: 21, weight: .bold, design: .default))
                Text("님은")
                    .font(.system(size: 21, weight: .medium))
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("열심히 운동 중!🏃🏻‍♂️")
                .foregroundColor(Color.mainTextColor)
                .font(.system(size: 28, weight: .bold, design: .default))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            
            Text("운동이 완료되면\n워치의 운동 기록 측정을 종료하고\n운동 완료하기 버튼을 눌러주세요")
                .foregroundColor(Color.mainTextColor)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
                .font(.system(size: 17, weight: .regular, design: .default))
                .lineSpacing(TextUtil().calculateLineSpacing(17, 143.5))
            
            Spacer()
            ZStack {
                //이미지 들어가기
                Image(systemName: "figure.strengthtraining.traditional")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 178, height: 180)
                    .foregroundColor(Color.bunnyColor)
            }
            Spacer()
            NavigationLink(isActive: $isNextButtonTapped, destination: {
                SingleWorkoutDoneView(userModel: userModel, bunnyModel: bunnyModel, workoutModel: workoutModel, mainViewNavLinkActive: $mainViewNavLinkActive)
            }, label: {
                Button("운동 완료하기") {
                    // 목표량 달성 여부 확인
                    
                    // 운동 데이터 가져오기
                    healthData.fetchAfterWorkoutTime()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        // 나의 데이터를 CoreData에 저장
                        userModel.todayWorkoutHours = healthData.workoutDuration
                        userModel.todayCalories = healthData.workoutCalorie
                        userModel.saveUserData()
                        
                        // MARK: - 목표치 채웠는지 확인하고, 채웠으면 연결, 못 채웠으면 모달창 뜨게 하기
                        // 내가 목표 칼로리를 다 채웠으면
                        if userModel.goalCalories <= userModel.todayCalories {
                            // 파트너와 재연결(수고하셨어요) 뷰로 넘어가기
                            UserDefaults.standard.set(true, forKey: "isDoneWorkout")
                            UserDefaults.standard.set(false, forKey: "isWorkouting")
                            isNextButtonTapped = true
                        }
                        else {
                            // 넘지 못하면 모달 뷰 띄우기
                            self.isNotDoneWorkout = true
                            UserDefaults.standard.set(false, forKey: "isDoneWorkout")
                            UserDefaults.standard.set(false, forKey: "isWorkouting")
                        }
                    }
                }.buttonStyle(RedButtonStyle())
            })
        }
        .navigationBarHidden(true)
        .padding(EdgeInsets(top: 50, leading: 30, bottom: 15, trailing: 30)) // 전체 아웃라인
        .background(Color.backgroundColor) // 고급진 까만것이 필요할 듯
        .sheet(isPresented: self.$isNotDoneWorkout) {
            if #available(iOS 16.0, *) {
                MissionResultModalView(title: "아직 목표량을 채우지 못했어요!", article: "그래도 운동을 종료하시겠어요?", leftButtonName: "더 해볼게요", rightButtonName: "그만할래요", wantQuitWorkout: $isNextButtonTapped)
                    .presentationDetents([.fraction(0.4)])
                    .background(Color.backgroundColor)
            }
        }
    }
}



#Preview {
    SingleWorkoutView(userModel: UserModel(), bunnyModel: BunnyModel(), workoutModel: WorkoutModel(), healthData: HealthData(), mainViewNavLinkActive: .constant(true))
}

//
//  WorkoutView.swift
//  BurningBuddy
//
//  Created by 김동현 on 2023/05/02.
//

import Foundation
import SwiftUI

/**
 일단 settings에 데이터를 저장하고 상대방에게 settings 또는 만들어진 데이터모델을 전달하는 것이 중요.
 동시에 만들어진 데이터모델을 받아서 settings 내부에 저장하는 것이 필요.
 */
struct WorkoutView: View {
    @EnvironmentObject var settings: UserSettings
//    @State private var tag: Int? = nil
    @State private var isWorkoutDonePressed = false
    
    var body: some View {
        VStack {
            HStack {
                Text(settings.nickName)
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

            NavigationLink(isActive: $isWorkoutDonePressed, destination: {
                WorkoutDoneView()
            }, label: {
                Button("운동 완료하기") {
                    settings.workoutData.fetchAfterWorkoutTime()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        settings.todayCalories = Int16(settings.workoutData.workoutCalorie)
                        settings.totalWorkoutTime = settings.workoutData.workoutDuration
                        isWorkoutDonePressed = true
                    }
                }
                .buttonStyle(RedButtonStyle())
            })

        }
        .navigationBarHidden(true)
        .padding(EdgeInsets(top: 10, leading: 30, bottom: 15, trailing: 30)) // 전체 아웃라인
        .background(Color.backgroundColor) // 고급진 까만것이 필요할 듯
        
    }
}


struct WorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutView().environmentObject(UserSettings())
    }
}

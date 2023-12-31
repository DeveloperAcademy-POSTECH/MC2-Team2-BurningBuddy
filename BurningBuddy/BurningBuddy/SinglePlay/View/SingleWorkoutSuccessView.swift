//
//  SingleWorkoutSuccessView.swift
//  BurningBuddy
//
//  Created by Bokyung on 2023/09/30.
//

import SwiftUI


struct SingleWorkoutSuccessView: View {
    @ObservedObject var userModel: UserModel
    @ObservedObject var bunnyModel: BunnyModel
    @ObservedObject var workoutModel: WorkoutModel
    @Binding var mainViewNavLinkActive: Bool
    var body: some View {
        SingleMissionCongratsView(userModel: userModel, bunnyModel: bunnyModel, workoutModel: workoutModel, title: "축하해요!🎉\n목표달성에 성공했어요!", article: "목표달성에 성공해,\n 핑크 덤벨 하나를 선물 드려요!", imageName: "dumbbell.fill", buttonName: "메인으로 가기", imageTiltValue: -45, mainViewNavLinkActive: $mainViewNavLinkActive)
    }
}

#Preview {
    SingleWorkoutSuccessView(userModel: UserModel(), bunnyModel: BunnyModel(), workoutModel: WorkoutModel(), mainViewNavLinkActive: .constant(true))
}

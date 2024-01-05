//
//  SingleWorkoutFailView.swift
//  BurningBuddy
//
//  Created by Bokyung on 2023/09/30.
//

import SwiftUI

struct SingleWorkoutFailView: View {
    @ObservedObject var userModel: UserModel
    @ObservedObject var bunnyModel: BunnyModel
    @ObservedObject var workoutModel: WorkoutModel
    @Binding var mainViewNavLinkActive: Bool
    
    var body: some View {
        MissionCongratsView(userModel: userModel, bunnyModel: bunnyModel, workoutModel: workoutModel, title: "저런...🥲\n아쉽네요", article: "목표달성에 실패했습니다!\n아쉽지만 다음 운동 때는 더 힘내봐요!", imageName: "face.dashed", buttonName: "메인으로 가기", imageTiltValue: 0, mainViewNavLinkActive: $mainViewNavLinkActive)
    }
}

#Preview {
    SingleWorkoutFailView (userModel: UserModel(), bunnyModel: BunnyModel(), workoutModel: WorkoutModel(), mainViewNavLinkActive: .constant(true))
}

//
//  WorkoutSuccessView.swift
//  BurningBuddy
//
//  Created by 김동현 on 2023/05/10.
//

import SwiftUI

struct WorkoutSuccessView: View {
    @ObservedObject var userModel: UserModel
    @ObservedObject var bunnyModel: BunnyModel
    @ObservedObject var workoutModel: WorkoutModel
    @Binding var mainViewNavLinkActive: Bool
    var body: some View {
        MissionCongratsComponent(userModel: userModel, bunnyModel: bunnyModel, workoutModel: workoutModel, title: "축하해요!🎉\n목표달성에 성공했어요!", article: "나와 파트너가 모두 목표달성에\n성공해, 핑크 덤벨 하나를 선물 드려요!", imageName: "dumbbell.fill", buttonName: "메인으로 가기", imageTiltValue: -45, mainViewNavLinkActive: $mainViewNavLinkActive)
    }
}
//
//struct WorkoutSuccessView_Previewer: PreviewProvider {
//    static var previews: some View {
//        WorkoutSuccessView()
//    }
//}

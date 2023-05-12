//
//  WorkoutFailView.swift
//  BurningBuddy
//
//  Created by 김동현 on 2023/05/10.
//

import SwiftUI

struct WorkoutFailView: View {
    @Binding var mainViewNavLinkActive: Bool
    
    var body: some View {
        MissionCongratsComponent(title: "저런...🥲\n아쉽네요", article: "둘 중 한 명이 목표달성에 실패했습니다!\n아쉽지만 다음 운동 때는 더 힘내봐요!", imageName: "face.dashed", buttonName: "메인으로 가기", imageTiltValue: 0, mainViewNavLinkActive: $mainViewNavLinkActive)
    }
}

//struct WorkoutFailView_Previewer: PreviewProvider {
//    @Binding var mainViewNavLinkActive: Bool
//    static var previews: some View {
//        WorkoutFailView(mainViewNavLinkActive: $mainViewNavLinkActive)
//    }
//}

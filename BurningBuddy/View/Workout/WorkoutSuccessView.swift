//
//  WorkoutSuccessView.swift
//  BurningBuddy
//
//  Created by 김동현 on 2023/05/10.
//

import SwiftUI

struct WorkoutSuccessView: View {
    var body: some View {
        MissionCongratsComponent(title: "축하해요!🎉\n목표달성에 성공했어요!", article: "나와 파트너가 모두 목표달성에\n성공해서 핑크 덤벨 하나를 선물 드려요!", imageName: "dumbbell.fill", buttonName: "메인으로 가기")
    }
}

struct WorkoutSuccessView_Previewer: PreviewProvider {
    static var previews: some View {
        WorkoutSuccessView()
    }
}

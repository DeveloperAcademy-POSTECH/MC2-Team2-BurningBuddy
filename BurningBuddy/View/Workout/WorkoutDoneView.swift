//
//  WorkoutDoneView.swift
//  BurningBuddy
//
//  Created by 김동현 on 2023/05/04.
//

import Foundation
import SwiftUI

struct WorkoutDoneView: View {
    @EnvironmentObject var settings: UserSettings
    @State var isNotDoneWorkout = false
    
    var body: some View {
        VStack {
            Text("오늘도\n수고하셨어요!")
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.white)
                .font(.system(size: 30, weight: .bold, design: .default))
            
            Text("오늘 함께 운동한 파트너도\n운동이 끝났는지 확인해주세요!")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
                .font(.system(size: 17, weight: .regular, design: .default))
            
            Spacer()
            ZStack {
                Circle()
                    .foregroundColor(Color(red: 74/255, green: 74/255, blue: 77/255))
                    .padding(EdgeInsets(top: 30, leading: 30, bottom: 30, trailing: 30))
                
            }
            Spacer()
            Button("목표달성 확인하기", action: {
                isNotDoneWorkout = !isNotDoneWorkout
            })
            .buttonStyle(RedButtonStyle())
        }
        .padding(EdgeInsets(top: 20, leading: 25, bottom: 10, trailing: 25)) // 전체 아웃라인
        .background(Color(red: 30/255, green: 28/255, blue: 29/255)) // 고급진 까만것이 필요할 듯
        .sheet(isPresented: self.$isNotDoneWorkout) {
            if #available(iOS 16.0, *) {
                MissionResultModalView()
                    .presentationDetents([.fraction(0.4)])
                    .background(Color(red: 30/255, green: 28/255, blue: 29/255))
            } else {
                // Fallback on earlier versions
                MissionResultModalView()
                    .background(Color(red: 30/255, green: 28/255, blue: 29/255))
            }
        }
    }
}


struct WorkoutDoneView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutDoneView()
    }
}


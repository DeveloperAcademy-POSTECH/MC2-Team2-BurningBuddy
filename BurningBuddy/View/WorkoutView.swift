//
//  WorkoutView.swift
//  BurningBuddy
//
//  Created by 김동현 on 2023/05/02.
//

import Foundation
import SwiftUI

struct WorkoutView: View {
    @EnvironmentObject var settings: UserSettings
    
    var body: some View {
        VStack {
            HStack {
                Text(settings.nickName)
                    .font(.system(size: 25, weight: .bold, design: .default))
                Text("님은")
                    .font(.system(size: 25, weight: .medium))
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("열심히 운동중입니다...!")
                .foregroundColor(.white)
                .font(.system(size: 30, weight: .bold, design: .default))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            
            Text("운동이 완료되면,\n애플워치의 운동기록을 종료해주세요!")
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
            
            Button("운동 완료하기", action: {
                // Alert창. 파트너의 운동기록이 없거나 내 운동 종료 기록이 없으면 Alert 창이 다르게 떠야 함.
            })
            .buttonStyle(NextButtonStyle(colorRed: 255, colorGreen: 45, colorBlue: 85, fontSize: 17))
        }
        .padding(EdgeInsets(top: 20, leading: 25, bottom: 10, trailing: 25)) // 전체 아웃라인
        .background(Color(red: 30/255, green: 28/255, blue: 29/255)) // 고급진 까만것이 필요할 듯
    }
}


struct WorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutView().environmentObject(UserSettings())
    }
}

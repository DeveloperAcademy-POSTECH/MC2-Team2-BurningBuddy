//
//  MissionCongratsView.swift
//  BurningBuddy
//
//  Created by 김동현 on 2023/05/07.
//

import Foundation
import SwiftUI

struct MissionCongratsView: View {
    @EnvironmentObject var settings: UserSettings
    /**
     운동을 성공적으로 종료한 것을 감지하는 변수 필요
     */
    var body: some View {
        VStack {
            Text("이렇게 나약해서야...\n어디서 힘이나 쓰겠나!")
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.white)
                .font(.system(size: 30, weight: .bold, design: .default))
            
            Text("다음엔 열심히\n운동좀 하쇼!")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
                .font(.system(size: 17, weight: .regular, design: .default))
                .lineSpacing(TextUtil().calculateLineSpacing(17, 143.5))
            
            Spacer()
            ZStack {
                Circle()
                    .foregroundColor(Color(red: 74/255, green: 74/255, blue: 77/255))
                    .padding(EdgeInsets(top: 30, leading: 30, bottom: 30, trailing: 30))
                
            }
            Spacer()
            Button("메인으로 가기", action: {
            })
            .buttonStyle(RedButtonStyle())
        }
        .padding(EdgeInsets(top: 20, leading: 25, bottom: 10, trailing: 25)) // 전체 아웃라인
        .background(Color(red: 30/255, green: 28/255, blue: 29/255)) // 고급진 까만것이 필요할 듯
    }
}


struct MissionCongratsView_Previews: PreviewProvider {
    static var previews: some View {
        MissionCongratsView()
    }
}


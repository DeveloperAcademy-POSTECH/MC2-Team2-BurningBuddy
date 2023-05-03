//
//  WorkoutView.swift
//  BurningBuddy
//
//  Created by 김동현 on 2023/05/02.
//

import Foundation
import SwiftUI

struct WorkoutView: View {
    var body: some View {
        VStack {
            Text("내 파트너를 \n찾는 중이에요")
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.white)
                .font(.system(size: 30, weight: .bold, design: .default))
            Text("서로의 휴대폰을 가까이 붙여주세요")
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.white)
                .padding(EdgeInsets(top: 1, leading: 0, bottom: 90, trailing: 0))
            
            ZStack {
                Circle()
                    .foregroundColor(Color(red: 74/255, green: 74/255, blue: 77/255))
                    .padding(EdgeInsets(top: -8, leading: -8, bottom: -8, trailing: -8))
                
            }
            Spacer()
            
            Button("연결하기", action: {
                
            })
            .buttonStyle(NextButtonStyle(colorRed: 255, colorGreen: 45, colorBlue: 85, fontSize: 17))
        }
        .padding(EdgeInsets(top: 20, leading: 25, bottom: 10, trailing: 25))
        .background(Color(red: 30/255, green: 28/255, blue: 29/255)) // 고급진 까만것이 필요할 듯
    }
}


struct WorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutView()
    }
}

//
//  MainView.swift
//  BurningBuddy
//
//  Created by 김동현 on 2023/05/02.
//

import Foundation
import SwiftUI

struct MainView: View {
    @EnvironmentObject var settings: UserSettings
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Text(settings.nickName)
                        .font(.system(size: 25, weight: .bold, design: .default))
                    Text("님의")
                        .font(.system(size: 25, design: .default))
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(settings.characterName)
                    .foregroundColor(.white)
                    .font(.system(size: 30, weight: .bold, design: .default))
                    .frame(maxWidth: .infinity, alignment: .leading)

            }

            ProgressView(value: 50, total: 100)
                .scaleEffect(x: 1, y: 4, anchor: .center)
                .progressViewStyle(LinearProgressViewStyle(tint: Color(red: 255/255, green: 45/255, blue: 85/255)))
                .padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))

            Spacer()
            
            Button("다음", action: {
                // saveNickname()
                
            })
            .buttonStyle(NextButtonStyle(colorRed: 255, colorGreen: 45, colorBlue: 85, fontSize: 17))
        }
        .padding(EdgeInsets(top: 50, leading: 30, bottom: 30, trailing: 30))
        .background(Color(red: 30/255, green: 28/255, blue: 29/255)) // 고급진 까만것이 필요할 듯
        
    }
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView().environmentObject(UserSettings())
    }
}

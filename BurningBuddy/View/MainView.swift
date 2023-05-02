//
//  MainView.swift
//  BurningBuddy
//
//  Created by 김동현 on 2023/05/02.
//

import Foundation
import SwiftUI

struct MainView: View {
    @State var nickname: String = "테스트중"
    @State var characterName: String = "테스트캐릭터이름"
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
                .padding(EdgeInsets(top: 25, leading: 30, bottom: 0, trailing: 0))
                Text(settings.characterName)
                    .foregroundColor(.white)
                    .font(.system(size: 30, weight: .bold, design: .default))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(EdgeInsets(top: 0 , leading: 30, bottom: 0, trailing: 0))
            }
            
            
            Spacer()
            Spacer()
            Divider()
                .overlay(Color.white)
                .padding(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 30))
            Spacer()
            Spacer()
            Button("다음", action: {
                // saveNickname()
                
            })
            .buttonStyle(NextButtonStyle(colorRed: 255, colorGreen: 45, colorBlue: 85, fontSize: 17))
            Spacer()
        }
        .background(.black)
    }
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

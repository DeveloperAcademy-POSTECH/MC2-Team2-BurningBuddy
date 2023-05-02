//
//  CharacterSettingView.swift
//  BurningBuddy
//
//  Created by 김동현 on 2023/05/02.
//

import Foundation
import SwiftUI

struct CharacterSettingView: View {
    @ObservedObject var characterName = TextLimiter(limit: 8)
    @EnvironmentObject var settings: UserSettings
    
    var body: some View {
        VStack {
            Text("캐릭터 이름을\n설정해봐요!")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(EdgeInsets(top: 50, leading: 30, bottom: 0, trailing: 0))
                .foregroundColor(.white)
                .font(.custom("본고딕-Bold", size: 30))
            Spacer()
            Spacer()
            TextField("", text: $characterName.value, prompt: Text("캐릭터 이름은 한글 2~8자로 설정할 수 있어요!")
                .foregroundColor(.white))
            .padding(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 30))
            .foregroundColor(.white)
            Divider()
                .overlay(Color.white)
                .padding(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 30))
            
            Image("cookie")
                .scaledToFill()
                .frame(width: 400, height: 400)
            
            Button("캐릭터 만들기", action: {
                saveCharacterName()
                print(settings.pageNum)
            })
            .buttonStyle(NextButtonStyle(colorRed: 255, colorGreen: 45, colorBlue: 85, fontSize: 17))
            Spacer()
        }
        .background(.black)
    }
    
    func saveCharacterName() {
        settings.characterName = characterName.value
        withAnimation(.easeIn(duration: 0.9)){
            settings.pageNum += 1
        }
        
    }
}


struct CharacterSettingView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterSettingView()
    }
}

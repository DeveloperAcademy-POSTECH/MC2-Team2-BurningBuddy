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
            Text("캐릭터 이름을\n설정해주세요!")
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.white)
                .font(.system(size: 30, weight: .bold))
            Spacer()
            TextField("", text: $characterName.value, prompt: Text("캐릭터 이름은 한글 2~8자로 설정할 수 있어요!")
                .foregroundColor(.white))
            .foregroundColor(.white)
            Divider()
                .overlay(Color.white)
            Spacer()
            Button("캐릭터 만들기", action: {
                saveCharacterName()
                print(settings.pageNum)
            })
            .buttonStyle(RedButtonStyle())
        }
        .padding(EdgeInsets(top: 30, leading: 30, bottom: 30, trailing: 30))
        .background(Color(red: 30/255, green: 28/255, blue: 29/255)) // 고급진 까만것이 필요할 듯
    }
    
    func saveCharacterName() {
        // 코어데이터에 버니 생성
        CoreDataManager.coreDM.createBunny(characterName: characterName.value)
        settings.characterName = characterName.value // 임시 데이터
        withAnimation(.easeIn(duration: 0.5)){
            settings.pageNum += 1  
        }
    }
}



struct CharacterSettingView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterSettingView()
    }
}

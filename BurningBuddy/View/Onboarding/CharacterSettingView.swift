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
    @State private var isInputText: Bool = false
    
    var body: some View {
        VStack {
            Text("캐릭터 이름을\n설정해주세요!")
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.white)
                .font(.system(size: 30, weight: .bold))
            Text("내가 성장시키는\n버니의 이름을 지어주세요")
                .padding(EdgeInsets(top: 1, leading: 0, bottom: 0, trailing: 0))
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(Color.subTextColor)
                .font(.system(size: 17, weight: .medium))
                .lineSpacing(TextUtil().calculateLineSpacing(17, 143.5))
            Spacer()
            TextField("", text: $characterName.value, prompt: Text("캐릭터 이름은 한글 2~8자로 설정할 수 있어요!")
                .foregroundColor(Color.mainTextColor))
            .foregroundColor(.mainTextColor)
            Divider()
                .overlay(Color.mainTextColor)
            if isInputText {
                Text("캐릭터 이름이 입력되지 않았어요!")
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
                    .frame(maxWidth: .infinity, alignment: .center)
                    .foregroundColor(Color.primary)
                    .font(.system(size: 17, weight: .bold))
            }
            Spacer()
            Button("캐릭터 만들기", action: {
                saveCharacterName()
            })
            .buttonStyle(RedButtonStyle())
        }
        .padding(EdgeInsets(top: 30, leading: 30, bottom: 30, trailing: 30))
        .background(Color.backgroundColor)
    }
    
    private func saveCharacterName() {
        settings.characterName = characterName.value
        if settings.characterName.count == 0 || settings.characterName.count == 1 {
            self.isInputText = true
        } else {
            self.isInputText = false
            CoreDataManager.coreDM.createBunny(characterName: characterName.value)
            settings.characterName = characterName.value // 임시 데이터
            withAnimation(.easeIn(duration: 0.5)){
                settings.pageNum += 1
            }
        }
    }
}

struct CharacterSettingView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterSettingView()
    }
}

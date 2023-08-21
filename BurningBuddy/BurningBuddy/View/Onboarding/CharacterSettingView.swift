//
//  CharacterSettingView.swift
//  BurningBuddy
//
//  Created by 김동현 on 2023/05/02.
//

import Foundation
import SwiftUI

//TODO: -
/**
 NicknameSettingView와 동일한 구조를 가지고 있음.
 하나의 파일로 재사용할 수 있는 방법을 생각해 보아야 함.
 */
struct CharacterSettingView: View {
    @ObservedObject var characterName = TextLimiter(limit: 8)
    @EnvironmentObject var settings: UserSettings
    @State private var isInputText: Bool = false
    @State var isTopButtonHidden: Bool = false // 세팅뷰에서 재사용을 위한 변수
    
    var body: some View {
        VStack {
            if !isTopButtonHidden {
                Button(action: {
                    settings.pageNum -= 1
                }, label: {
                    Image(systemName: "chevron.left")
                        .resizable()
                        .frame(width: 10, height: 19)
                })
                .foregroundColor(Color.mainTextColor)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
            }
            Text("캐릭터 이름을\n설정해주세요")
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.white)
                .font(.system(size: 28, weight: .bold))
            Text("내가 성장시키는\n버니의 이름을 지어주세요")
                .padding(EdgeInsets(top: 1, leading: 0, bottom: 0, trailing: 0))
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(Color.subTextColor)
                .font(.system(size: 17, weight: .medium))
                .lineSpacing(TextUtil().calculateLineSpacing(17, 143.5))
            Spacer()
            TextField("", text: $characterName.value, prompt: Text("캐릭터 이름은 한글 2~8자로 설정할 수 있어요!")
                .foregroundColor(Color.subTextColor)).font(.system(size: 17, weight: .regular))
            
            
                .foregroundColor(.mainTextColor)
            Divider()
                .overlay(Color.mainTextColor)
            if isInputText {
                Text("캐릭터 이름이 입력되지 않았어요!")
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
                    .frame(maxWidth: .infinity, alignment: .center)
                    .foregroundColor(Color.bunnyColor)
                    .font(.system(size: 17, weight: .bold))
            }
            Spacer()
            Button("확인", action: {
                saveCharacterName()
            })
            .buttonStyle(RedButtonStyle())
        }
        .padding(EdgeInsets(top: 10, leading: 30, bottom: 15, trailing: 30))
        .background(Color.backgroundColor)
    }
    
    private func saveCharacterName() {
        settings.characterName = characterName.value
        if settings.characterName.count == 0 || settings.characterName.count == 1 {
            self.isInputText = true
        } else {
            self.isInputText = false
            
            CoreDataManager.shared.readAllBunny()[0].characterName = characterName.value
            CoreDataManager.shared.update()
            settings.characterName = characterName.value // 임시 데이터
            withAnimation(.easeIn(duration: 0.5)){
                if settings.pageNum != 4 { // SettingView에서 재사용하기 위해
                    settings.pageNum += 1
                }
            }
        }
    }
}

struct CharacterSettingView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterSettingView()
    }
}

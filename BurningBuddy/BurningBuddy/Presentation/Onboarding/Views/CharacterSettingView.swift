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
    @ObservedObject var bunnyModel: BunnyModel
    @ObservedObject var characterName = TextLimiter(limit: 8)
    @State private var isInputText: Bool = false
    @State var isTopButtonHidden: Bool = false // 세팅뷰에서 재사용을 위한 변수
    @Binding var pageNum: Int

    var body: some View {
        VStack {
            if !isTopButtonHidden {
                Button(action: {
                    pageNum -= 1
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
                .foregroundColor(Color.subTextColor))
                .font(.system(size: 17, weight: .regular))
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
            .buttonStyle(BurningBuddyButton(style: .red))
        }
        .padding(EdgeInsets(top: 10, leading: 30, bottom: 15, trailing: 30))
        .background(Color.backgroundColor)
    }
}

extension CharacterSettingView {
    private func checkBlackTextField() {
        if characterName.value.count == 0 || characterName.value.count == 1 {
            self.isInputText = true
        } else {
            self.isInputText = false
        }
    }

    private func saveCharacterName() {
        bunnyModel.bunnyName = characterName.value
        checkBlackTextField()
        if !isInputText {
            bunnyModel.saveBunnyData()
            withAnimation(.easeIn(duration: 0.5)) {
                if pageNum != 4 { // SettingView에서 재사용하기 위해
                    pageNum += 1
                }
            }
        }
    }
}

struct CharacterSettingView_Previews: PreviewProvider {
    @ObservedObject static var bunnyModel = BunnyModel()
    @State static var pageNum = 2
    static var previews: some View {
        CharacterSettingView(bunnyModel: bunnyModel, pageNum: $pageNum)
    }
}

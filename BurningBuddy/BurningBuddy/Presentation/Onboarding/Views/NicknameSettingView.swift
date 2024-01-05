//
//  NicknameSettingView.swift
//  BurningBuddy
//
//  Created by 김동현 on 2023/05/02.
//

import Foundation
import SwiftUI

struct NicknameSettingView: View {
    @ObservedObject var userModel: UserModel
    @ObservedObject var nicknameLimitter = TextLimiter(limit: 8)
    @State private var isInputText: Bool = false
    @Binding var pageNum: Int
    /*
     레이아웃 수정 필요. EdgeInsets 제거 등
     */
    var body: some View {
        VStack(spacing: 0) {
            Spacer().frame(height: 51)
            Text("닉네임을\n입력해주세요")
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(Color.mainTextColor)
                .font(.system(size: 28, weight: .bold))
            Spacer().frame(height: 8)
            Text("나중에 연결된\n파트너에게 보여져요")
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(Color.subTextColor)
                .font(.system(size: 17, weight: .medium))
                .lineSpacing(TextUtil().calculateLineSpacing(17, 143.5))
            Spacer()
            TextField("", text: $nicknameLimitter.value, prompt: Text("닉네임은 한글 2~8자로 설정할 수 있어요!")
                .foregroundColor(Color.subTextColor))
                .font(.system(size: 17, weight: .regular))
                .foregroundColor(Color.mainTextColor)
            Divider()
                .overlay(Color.mainTextColor)
            if isInputText {
                Text("닉네임이 입력되지 않았어요!")
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
                    .frame(maxWidth: .infinity, alignment: .center)
                    .foregroundColor(Color.bunnyColor)
                    .font(.system(size: 17, weight: .bold))
            }
            Spacer()
            Button("확인", action: {
                saveNickname()
            })
            .buttonStyle(BurningBuddyButton(style: .red))
        }
        .padding(EdgeInsets(top: 10, leading: 30, bottom: 15, trailing: 30))
        .background(Color.backgroundColor)
    }
}

extension NicknameSettingView {
    // TODO: -
    /**
     settings 제거하고, DataModel에 저장하는 방식으로 변경 필요.
     메서드를 DataModel을 만들어 거기에서 활용해야 함.
     */
    private func checkBlackTextField() {
        if nicknameLimitter.value.count == 0 || nicknameLimitter.value.count == 1 {
            self.isInputText = true
        } else {
            self.isInputText = false
        }
    }

    private func saveNickname() {
        userModel.userName = nicknameLimitter.value
        checkBlackTextField()
        if !isInputText {
            userModel.saveUserData()
            print(userModel.userName)
            withAnimation(.easeInOut(duration: 0.5)) {
                if pageNum != 4 { // SettingView에서 재사용하기 위해
                    pageNum += 1
                }
            }
        }
    }
}

struct NicknameSettingView_Previews: PreviewProvider {
    @ObservedObject static var userModel = UserModel()
    @State static var pageNum = 1

    static var previews: some View {
        NicknameSettingView(userModel: userModel, pageNum: $pageNum)
    }
}

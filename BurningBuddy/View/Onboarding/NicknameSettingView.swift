//
//  NicknameSettingView.swift
//  BurningBuddy
//
//  Created by 김동현 on 2023/05/02.
//

import Foundation
import SwiftUI

struct NicknameSettingView: View {
    @ObservedObject var nicknameLimiter = TextLimiter(limit: 8)
    @EnvironmentObject var settings: UserSettings
    @State private var isInputText: Bool = false
    @State var isTopButtonHidden: Bool = false // 세팅뷰에서 상단 크기를 맞추기 위한 버튼
    
    var body: some View {
        VStack {
            if !isTopButtonHidden {
                // 온보딩 페이지 크기를 맞추기 위한 히든 버튼
                Button(action: {
                    
                }, label: {
                    Image(systemName: "chevron.left")
                        .resizable()
                        .frame(width: 10, height: 19)
                }).foregroundColor(Color.backgroundColor)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
            }
            Text("닉네임을\n입력해주세요")
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(Color.mainTextColor)
                .font(.system(size: 28, weight: .bold))
            Text("나중에 연결된\n파트너에게 보여져요")
                .padding(EdgeInsets(top: 1, leading: 0, bottom: 0, trailing: 0))
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(Color.subTextColor)
                .font(.system(size: 17, weight: .medium))
                .lineSpacing(TextUtil().calculateLineSpacing(17, 143.5))
            Spacer()
 
            TextField("", text: $nicknameLimiter.value, prompt: Text("닉네임은 한글 2~8자로 설정할 수 있어요!")
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
            .buttonStyle(RedButtonStyle())
        }
        .padding(EdgeInsets(top: 10, leading: 30, bottom: 15, trailing: 30))
        .background(Color.backgroundColor) // 고급진 까만것이 필요할 듯
    }
    
    private func saveNickname() {
        settings.nickName = nicknameLimiter.value
        if settings.nickName.count == 0 || settings.nickName.count == 1{
            self.isInputText = true
        } else {
            CoreDataManager.coreDM.readAllUser()[0].userName = nicknameLimiter.value
            CoreDataManager.coreDM.update()
            self.isInputText = false
            
            withAnimation(.easeInOut(duration: 0.5)){
                if settings.pageNum != 4 { // SettingView에서 재사용하기 위해
                    settings.pageNum += 1
                }
            }
        }
    }
}



class TextLimiter: ObservableObject {
    private let limit: Int
    init(limit: Int) {
        self.limit = limit
    }
    
    @Published var value = "" {
        didSet {
            if value.count > self.limit {
                value = String(value.prefix(self.limit))
                self.hasReachedLimit = true
            } else {
                self.hasReachedLimit = false
            }
        }
    }
    @Published var hasReachedLimit = false
}


struct NicknameSettingView_Previews: PreviewProvider {
    @State var isMember: Bool = true
    
    static var previews: some View {
        NicknameSettingView()
    }
}


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
    @State private var firstSliderDrag: Bool = false
    @State private var sliderValue: Double = 200
    @State private var sliderMessage: String = "목표 칼로리를 설정해주세요!"
    
    var body: some View {
        VStack {
            Text("닉네임을\n입력해주세요!")
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.white)
                .font(.system(size: 30, weight: .bold))
            Spacer()
            Spacer()
            TextField("", text: $nicknameLimiter.value, prompt: Text("닉네임은 한글 2~8자로 설정할 수 있어요!")
                .foregroundColor(.white))
            .foregroundColor(.white)
            Divider()
                .overlay(Color.white)
            
            Spacer()
            Spacer()
            Button("다음", action: {
                saveNickname()
            })
            .buttonStyle(RedButtonStyle())
        }
        .padding(EdgeInsets(top: 30, leading: 30, bottom: 30, trailing: 30))
        .background(Color(red: 30/255, green: 28/255, blue: 29/255)) // 고급진 까만것이 필요할 듯
    }
    
    private func saveNickname() {
        settings.nickName = nicknameLimiter.value
        withAnimation(.easeInOut(duration: 0.5)){
            settings.pageNum += 1
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


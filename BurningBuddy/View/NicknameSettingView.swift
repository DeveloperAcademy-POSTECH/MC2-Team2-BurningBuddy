//
//  NicknameSettingView.swift
//  BurningBuddy
//
//  Created by 김동현 on 2023/05/02.
//

import Foundation
import SwiftUI

struct NicknameSettingView: View {
//    @Binding var isMember: Bool
    @State var nickname: String = ""
    
    var body: some View {
        VStack {
            Text("반갑습니다! \n닉네임을 설정해봐요!")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(EdgeInsets(top: 50, leading: 30, bottom: 0, trailing: 0))
                .foregroundColor(.white)
                .font(.custom("본고딕-Bold", size: 30))
            Spacer()
            
            TextField("닉네임을 입력해주세요!", text: $nickname, prompt: Text("닉네임을 입력해주세요!")
                .foregroundColor(.white))
                .padding(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 30))
                .foregroundColor(.white)
            Divider()
                .overlay(Color.white)
                .padding(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 30))
            Spacer()
            Button(action: {
                print("다음버튼 클릭")
            }) {
                Text("다음")
                    .foregroundColor(.white)
                
            }
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
            .frame(height: 50)
            .cornerRadius(30)
            .background(Color(red: 255/255, green: 45/255, blue: 75/255))
            
            Spacer()
        }
        .background(.black)
    }
}

struct NicknameSettingView_Previews: PreviewProvider {
    @State var isMember: Bool = true
    
    static var previews: some View {
        NicknameSettingView()
    }
}


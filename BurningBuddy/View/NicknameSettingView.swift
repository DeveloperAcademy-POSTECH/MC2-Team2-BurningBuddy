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
            Spacer()
            TextField("", text: $nickname, prompt: Text("닉네임을 입력해주세요!")
                .foregroundColor(.white))
            .padding(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 30))
            .foregroundColor(.white)
            Divider()
                .overlay(Color.white)
                .padding(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 30))
            Spacer()
            Spacer()
            Button("다음", action: {
                print("다음버튼 클릭")
            })
            .buttonStyle(NextButtonStyle(colorRed: 255, colorGreen: 45, colorBlue: 85, fontSize: 17))
            Spacer()
        }
        .background(.black)
    }
}

struct NextButtonStyle: ButtonStyle {
    @State var colorRed: Double
    @State var colorGreen: Double
    @State var colorBlue: Double
    @State var fontSize: CGFloat
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.custom("본고딕-Medium", size: fontSize))
            .padding()
            .frame(minWidth: 0, maxWidth: .infinity)
            .foregroundColor(.white)
            .background(RoundedRectangle(cornerRadius: 15.0).fill(Color(red: colorRed / 255, green: colorGreen / 255, blue: colorBlue / 255))
            )
    }
    
}

struct NicknameSettingView_Previews: PreviewProvider {
    @State var isMember: Bool = true
    
    static var previews: some View {
        NicknameSettingView()
    }
}


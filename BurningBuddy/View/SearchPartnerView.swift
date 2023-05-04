//
//  SearchPartnerView.swift
//  BurningBuddy
//
//  Created by 김동현 on 2023/05/02.
//

import Foundation
import SwiftUI
/**
 화면 분할하여 파일 재생성 하기
 */
struct SearchPartnerView: View {
    @EnvironmentObject var settings: UserSettings
    @State var isSearchedPartner: Bool = false
    @State var partnerData: String = "상대방 닉네임" // 데이터 타입 지정 필요
    var body: some View {
        VStack {
            if isSearchedPartner {
                Text("내 파트너를 \n찾는 중이에요")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.white)
                    .font(.system(size: 30, weight: .bold, design: .default))
                Text("서로의 휴대폰을 가까이 붙여주세요")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.white)
                    .padding(EdgeInsets(top: 1, leading: 0, bottom: 90, trailing: 0))
            } else {
                Text("내 주변 파트너를 \n발견했어요")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.white)
                    .font(.system(size: 30, weight: .bold, design: .default))
                Text("연결할 파트너가 맞나요?")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.white)
                    .padding(EdgeInsets(top: 1, leading: 0, bottom: 90, trailing: 0))
            }
            ZStack {
                Circle()
                    .foregroundColor(Color(red: 44/255, green: 44/255, blue: 46/255))
                    .padding(EdgeInsets(top: -70, leading: -70, bottom: -70, trailing: -70))
                Circle()
                    .foregroundColor(Color(red: 74/255, green: 74/255, blue: 77/255))
                    .padding(EdgeInsets(top: -8, leading: -8, bottom: -8, trailing: -8))
                Circle()
                    .foregroundColor(Color(red: 124/255, green: 124/255, blue:129/255, opacity: 0.8))
                    .padding(EdgeInsets(top: 54, leading: 54, bottom: 54, trailing: 54))
                VStack {
                    if isSearchedPartner {
                        Text("이미지가 들어갈 것이다.")
                        Text("검색중...")
                    } else {
                        Image("Image")
                        Text(partnerData)
                    }
                }
                .padding(EdgeInsets(top: 106, leading: 106, bottom: 106, trailing: 106))
                
            }
            Spacer()
            if isSearchedPartner {
                
            } else {
                
                HStack {
                    Button("다시 연결할래요", action: {
                        
                    })
                    .buttonStyle(NextButtonStyle(colorRed: 199, colorGreen: 199, colorBlue: 204, fontSize: 17, fontColor: Color(red: 28/255, green: 28/255, blue: 30/255)))
                    
                    Button("연결하기", action: {
                        
                    })
                    .buttonStyle(NextButtonStyle(colorRed: 255, colorGreen: 45, colorBlue: 85, fontSize: 17))
                }
            }
            
        }
        .padding(EdgeInsets(top: 20, leading: 25, bottom: 10, trailing: 25))
        .background(Color(red: 30/255, green: 28/255, blue: 29/255)) // 고급진 까만것이 필요할 듯
    }
    
}


struct SearchPartnerView_Previews: PreviewProvider {
    static var previews: some View {
        SearchPartnerView()
    }
}

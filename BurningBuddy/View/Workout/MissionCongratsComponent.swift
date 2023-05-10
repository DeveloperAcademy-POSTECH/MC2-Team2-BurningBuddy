//
//  MissionCongratsView.swift
//  BurningBuddy
//
//  Created by 김동현 on 2023/05/07.
//

import Foundation
import SwiftUI
/**
 특별한 로직은 필요 없을 것 같다.
 왜냐하면, 특정한 조건에 나오는 뷰이기 때문이다.
 실패한 캐릭터만 보여주면 족하다. 메인으로 가는 이동 액션만 잘 넣어주면 되겠다.
 */
struct MissionCongratsComponent: View {
//    @EnvironmentObject var settings: UserSettings
    @State var title: String
    @State var article: String
    @State var imageName: String
    @State var buttonName: String
    
    /**
     운동을 성공적으로 종료한 것을 감지하는 변수 필요
     */
    var body: some View {
        VStack {
            Text(title)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.white)
                .font(.system(size: 30, weight: .bold, design: .default))
            
            Text(article)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
                .font(.system(size: 17, weight: .regular, design: .default))
                .lineSpacing(TextUtil().calculateLineSpacing(17, 143.5))
            
            Spacer()
            Image(systemName: imageName)
                .resizable()
                .frame(width: 182, height: 137)
                .padding(EdgeInsets(top: 30, leading: 30, bottom: 30, trailing: 30))
                .foregroundColor(.red)
                .rotationEffect(Angle(degrees: -45))
                
            
            Spacer()
            Button(buttonName, action: {
            })
            .buttonStyle(RedButtonStyle())
        }
        .padding(EdgeInsets(top: 20, leading: 25, bottom: 10, trailing: 25)) // 전체 아웃라인
        .background(Color(red: 30/255, green: 28/255, blue: 29/255))
    }
}


struct MissionCongratsView_Previews: PreviewProvider {
    static var previews: some View {
        MissionCongratsComponent(title: "축하해요!🎉\n목표달성에 성공했어요!", article: "나의 파트너가 목표 달성에\n성공해서 핑크덤벨 하나를 선물로 드려요!", imageName: "dumbbell.fill", buttonName: "메인으로 가기")
    }
}


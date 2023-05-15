//
//  EvolutionView.swift
//  BurningBuddy
//
//  Created by 김동현 on 2023/05/07.
//

import Foundation
import SwiftUI

/**
 특별한 로직은 필요 없을 것 같다.
 왜냐하면, 특정한 조건에 나오는 뷰이기 때문이다.
 단순히 진화하는 캐릭터만 보여주면 족하다.
 */
struct LevelUpView: View {
    @EnvironmentObject var settings: UserSettings
    
    var body: some View {
        VStack {
            Text("우와!\n버디가 진화했어요!")
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(Color.mainTextColor)
                .font(.system(size: 30, weight: .bold, design: .default))
            
            Text("핑크 덤벨 \(settings.totalDumbbell)개를 얻어\n\(settings.characterName)(이)가 진화했어요!")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 17, weight: .regular, design: .default))
                .padding(EdgeInsets(top: 1, leading: 0, bottom: 0, trailing: 0))
                .foregroundColor(Color.subTextColor)
                .lineSpacing(TextUtil().calculateLineSpacing(17, 142.5))
            
            Spacer()
            ZStack {
                Image("Bunny_Level\(settings.level)_front")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 450)
                
            }
            Spacer()
            Button("메인으로 가기", action: {
                
            })
            .buttonStyle(RedButtonStyle())
        }
        .padding(EdgeInsets(top: 20, leading: 30, bottom: 15, trailing: 30)) // 전체 아웃라인
        .background(Color.backgroundColor) // 고급진 까만것이 필요할 듯
    }
}


struct LevelUpView_Previews: PreviewProvider {
    static var previews: some View {
        LevelUpView()
            .environmentObject(UserSettings())
    }
}

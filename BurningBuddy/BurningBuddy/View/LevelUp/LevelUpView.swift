//
//  EvolutionView.swift
//  BurningBuddy
//
//  Created by 김동현 on 2023/05/07.
//

import Foundation
import SwiftUI

//TODO: -
/**
 settings 변수만 수정해주면 된다.
 EdgeInsets 등 레이아웃만 수정하면 됨.
 */
struct LevelUpView: View {
    @ObservedObject var userModel: UserModel
    @ObservedObject var bunnyModel: BunnyModel
    
    var body: some View {
        VStack {
            Text("우와!\n버디가 진화했어요!")
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(Color.mainTextColor)
                .font(.system(size: 30, weight: .bold, design: .default))
            
            Text("핑크 덤벨 \(userModel.totalDumbbell)개를 얻어\n\(bunnyModel.bunnyName)(이)가 진화했어요!")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 17, weight: .regular, design: .default))
                .padding(EdgeInsets(top: 1, leading: 0, bottom: 0, trailing: 0))
                .foregroundColor(Color.subTextColor)
                .lineSpacing(TextUtil().calculateLineSpacing(17, 142.5))
            
            Spacer()
            ZStack {
                Image("Bunny_\(bunnyModel.bunnyLevel)_front")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 350)
                
            }
            Spacer()
        }
        .padding(EdgeInsets(top: 20, leading: 30, bottom: 15, trailing: 30)) // 전체 아웃라인
        .background(Color.backgroundColor) // 고급진 까만것이 필요할 듯
    }
}


struct LevelUpView_Previews: PreviewProvider {
    @ObservedObject static var userModel = UserModel()
    @ObservedObject static var bunnyModel = BunnyModel()
    
    static var previews: some View {
        LevelUpView(userModel: userModel, bunnyModel: bunnyModel)
    }
}


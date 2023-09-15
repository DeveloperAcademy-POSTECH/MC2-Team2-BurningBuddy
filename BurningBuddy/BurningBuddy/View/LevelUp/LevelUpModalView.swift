//
//  LevelUpModalView.swift
//  BurningBuddy
//
//  Created by 김동현 on 2023/05/02.
//

import Foundation
import SwiftUI

/**
 settings 변수만 수정해주면 된다.
 EdgeInsets 등 레이아웃만 수정하면 됨.
 */
struct LevelUpModalView: View {
    @ObservedObject var userModel: UserModel
    @ObservedObject var bunnyModel: BunnyModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            HStack{
                Text("목표달성 \(userModel.totalDumbbell)일 째")
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    .foregroundColor(Color.mainTextColor)
                    .font(.system(size: 28, weight: .bold))
                Image(systemName: "dumbbell.fill")
                    .rotationEffect(Angle(degrees: -45))
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    .foregroundColor(Color.bunnyColor)
                Spacer()
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image("Close")
                        .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
                }
            }
            .padding(EdgeInsets(top: 30, leading: 0, bottom: 0, trailing: 0))
            
            Text("핑크 덤벨 개수는 \n운동목표 달성일과 동일해요")
                .fixedSize(horizontal: false, vertical: true)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(Color.subTextColor)
                .font(.system(size: 17, weight: .medium))
                .lineSpacing(TextUtil().calculateLineSpacing(17, 143.5))
            Image("roadMapLevel\(bunnyModel.bunnyLevel)")
                .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
            Spacer()
            
        }
        .padding(EdgeInsets(top: 30, leading: 30, bottom: 30, trailing: 30))
        .background(Color.backgroundColor)
    }
  
    
}

struct LevelUpModalView_Previews: PreviewProvider {
    @ObservedObject static var userModel = UserModel()
    @ObservedObject static var bunnyModel = BunnyModel()
    
    static var previews: some View {
        LevelUpModalView(userModel: userModel, bunnyModel: bunnyModel)
    }
}

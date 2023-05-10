//
//  EvolutionModalView.swift
//  BurningBuddy
//
//  Created by 김동현 on 2023/05/02.
//

import Foundation
import SwiftUI


struct LevelUpModalView: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            HStack{
                Text("목표달성 n일 째")
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    .foregroundColor(.white)
                    .font(.system(size: 28, weight: .bold))
                Image(systemName: "dumbbell.fill")
                    .rotationEffect(Angle(degrees: -45))
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    .foregroundColor(Color.bunnyColor)
                Spacer()
                Button(action: {
                    presentationMode.wrappedValue.dismiss()                       }) {
                           Image("Close")
                           .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
                       }
            }
            .padding(EdgeInsets(top: 30, leading: 0, bottom: 0, trailing: 0))
            
           
            
            Text("핑크 덤벨 개수는 \n운동목표 달성일과 동일해요")
                .fixedSize(horizontal: false, vertical: true)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(Color(red: 1, green: 1, blue: 1, opacity: 0.65))
                .font(.system(size: 17, weight: .medium))
                .lineSpacing(TextUtil().calculateLineSpacing(17, 143.5))
            Image("EvolutionRoadmap")
                .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
            Spacer()
            
        }
        .padding(EdgeInsets(top: 30, leading: 30, bottom: 30, trailing: 30))
        .background(Color(red: 30/255, green: 28/255, blue: 29/255))
        
    }
  
    struct LevelUpModalView_Previews: PreviewProvider {
        static var previews: some View {
            LevelUpModalView()
        }
    }
}


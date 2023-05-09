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
                    .padding(EdgeInsets(top: 50, leading: 0, bottom: 0, trailing: 0))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.white)
                    .font(.system(size: 30, weight: .bold))
                Image("dumbell")
                    .padding(EdgeInsets(top:50, leading: 0, bottom: 0, trailing: 100))
                
                
                Button(action: {
                         print("button pressed")
                    presentationMode.wrappedValue.dismiss()                       }) {
                           Image("Close")
                           .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
                           
                          
                       }
                
            }
            
           
            
            Text("핑크 덤벨 개수는 \n운동목표 달성일과 동일해요")
                .fixedSize(horizontal: false, vertical: true)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(Color(red: 1, green: 1, blue: 1, opacity: 0.65))
                .font(.system(size: 17, weight: .medium))
                .lineSpacing(TextUtil().calculateLineSpacing(17, 143.5))
            Image("EvolutionRoadmap")
                .padding(EdgeInsets(top: 60, leading: 0, bottom: 0, trailing: 0))
                
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


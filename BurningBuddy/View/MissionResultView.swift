//
//  MissionResultView.swift
//  BurningBuddy
//
//  Created by 김동현 on 2023/05/07.
//

import Foundation
import SwiftUI

struct MissionResultView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            // 모달 뷰의 제목
            ZStack {
                Text("당신은 너무 약하다")
                    .font(.system(size: 17, weight: .semibold))
            }
            Spacer()
            
            // 모달 뷰의 텍스트
            Text("아직 목표치를 채우지 못했어요!\n그래도 운동을 종료하시겠어요?")
                .multilineTextAlignment(.center)
                .font(.system(size: 17, weight: .medium))
                .lineSpacing(TextUtil().calculateLineSpacing(17, 100))
            Spacer()
            // 모달 뷰의 버튼
            Button(action: {
                // 버튼을 눌렀을 때 수행할 액션
                presentationMode.wrappedValue.dismiss()
                
            }, label: {
                Text("됐어... 난 글렀어...")
            })
            .buttonStyle(RedButtonStyle())
        }
        .padding(EdgeInsets(top: 30, leading: 30, bottom: 30, trailing: 30))
        
    }
}


struct MissionResultView_Previews: PreviewProvider {
    static var previews: some View {
        MissionResultView()
    }
}

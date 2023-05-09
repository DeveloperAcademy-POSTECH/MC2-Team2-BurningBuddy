//
//  MissionResultModalView.swift
//  BurningBuddy
//
//  Created by 김동현 on 2023/05/07.
//

import Foundation
import SwiftUI
/**
 특별한 로직은 필요 없을 것 같다.
 왜냐하면, 특정한 조건에 나오는 뷰이기 때문이다.
 단, 됐어,,, 난 글렀어,,,를 탭했을 때, 덤벨 수를 증가시키지 않고 운동을 종료하는 것이 필요하다.
 */
struct MissionResultModalView: View {
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
        MissionResultModalView()
    }
}

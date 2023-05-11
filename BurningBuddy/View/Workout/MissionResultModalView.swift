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
    @State var title: String = "title"
    @State var article: String = "article"
    @State var imageName: String = "exclamationmark.circle.fill"
    @State var leftButtonName: String = "cancel"
    @State var rightButtonName: String = "okay"
    @Binding var tag: Int?
    
    var body: some View {
        VStack {
            // 모달 뷰의 제목
            ZStack {
                Text(title)
                    .font(.system(size: 17, weight: .semibold))
            }
            Spacer()
            Image(systemName: imageName)
                .resizable()
                .frame(width: 93, height: 91)
            // 모달 뷰의 텍스트
            Spacer()
            Text(article)
                .multilineTextAlignment(.center)
                .font(.system(size: 17, weight: .medium))
                .lineSpacing(TextUtil().calculateLineSpacing(17, 100))
            Spacer()
            // 모달 뷰의 버튼
            HStack {
                Button(action: {
                    // 버튼을 눌렀을 때 수행할 액션
                    presentationMode.wrappedValue.dismiss()
                    
                }, label: {
                    Text(leftButtonName)
                })
                .buttonStyle(GrayButtonStyle())
                
                Button(action: {
                    // 버튼을 눌렀을 때 수행할 액션
                    presentationMode.wrappedValue.dismiss()
                    self.tag = 1
                }, label: {
                    Text(rightButtonName)
                })
                .buttonStyle(RedButtonStyle())
            }
        }
        .padding(EdgeInsets(top: 10, leading: 30, bottom: 15, trailing: 30))
        
    }
}

//
//struct MissionResultView_Previews: PreviewProvider {
//    static var previews: some View {
//        MissionResultModalView(tag: )
//    }
//}

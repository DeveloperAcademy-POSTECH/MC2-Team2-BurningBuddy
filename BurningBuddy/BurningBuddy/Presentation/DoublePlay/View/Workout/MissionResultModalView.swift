//
//  MissionResultModalView.swift
//  BurningBuddy
//
//  Created by 김동현 on 2023/05/07.
//

import Foundation
import SwiftUI
/**
 단, 됐어,,, 난 글렀어,,,를 탭했을 때, 덤벨 수를 증가시키지 않고 운동을 종료하는 것이 필요하다.
 */
struct MissionResultModalView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var title: String = "title"
    @State var article: String = "article"
    @State var imageName: String = "exclamationmark.circle.fill"
    @State var leftButtonName: String = "cancel"
    @State var rightButtonName: String = "okay"
    @Binding var wantQuitWorkout: Bool
    
    var body: some View {
        VStack {
            // 모달 뷰의 제목
            ZStack {
                Text(title)
                    .font(.system(size: 17, weight: .semibold))
            }
            Spacer()
            Image(systemName: imageName) // TODO: - 아이콘 이미지
                .resizable()
                .frame(width: 89, height: 87)
                .foregroundColor(Color.bunnyColor)
            // 모달 뷰의 텍스트
            Spacer()
            Text(article)
                .multilineTextAlignment(.center)
                .font(.system(size: 17, weight: .medium))
                .lineSpacing(TextUtil().calculateLineSpacing(17, 100))
            Spacer()
            // 모달 뷰의 버튼
            HStack(spacing: 13) {
                Button(action: { // left Button
                    presentationMode.wrappedValue.dismiss()
                    
                }, label: {
                    Text(leftButtonName)
                })
                .buttonStyle(BurningBuddyButton(style: .greyShort))
//                Spacer()// TODO: - 버튼 간격 조정
//                Spacer()
                Button(action: { // right Button
                    UserDefaults.standard.set(false, forKey: "isWorkouting")
                    wantQuitWorkout = true
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text(rightButtonName)
                })
                .buttonStyle(BurningBuddyButton(style: .redShort))
            }
        }
        .padding(EdgeInsets(top: 30, leading: 30, bottom: 15, trailing: 30))
        .navigationBarHidden(true)
    }
}


struct MissionResultView_Previews: PreviewProvider {
    @State static var value: Bool = true
    static var previews: some View {
        MissionResultModalView(title: "타이틀", article: "아티클", imageName: "exclamationmark.circle.fill", leftButtonName: "왼쪽버튼", rightButtonName: "오른쪽버튼", wantQuitWorkout: $value)
    }
}

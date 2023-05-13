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
    @EnvironmentObject var settings: UserSettings
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
            Image(systemName: imageName)
                .resizable()
                .frame(width: 93, height: 91)
                .foregroundColor(Color.bunnyColor)
            // 모달 뷰의 텍스트
            Spacer()
            Text(article)
                .multilineTextAlignment(.center)
                .font(.system(size: 17, weight: .medium))
                .lineSpacing(TextUtil().calculateLineSpacing(17, 100))
            Spacer()
            // 모달 뷰의 버튼
            HStack {
                Button(action: { // left Button
                    presentationMode.wrappedValue.dismiss()
                    
                }, label: {
                    Text(leftButtonName)
                })
                .buttonStyle(GrayButtonStyle())
                
                Button(action: { // right Button
                    //settings.isWorkouting = false // 운동중 변수를 false로 만들어준다.
                    UserDefaults.standard.set(false, forKey: "isWorkouting")
                    
                    print("workQuitWorkout 변경 전 : \(wantQuitWorkout)")
                    wantQuitWorkout = true
                    print("workQuitWorkout 변경 후 : \(wantQuitWorkout)")
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text(rightButtonName)
                })
                .buttonStyle(RedButtonStyle())
            }
        }
        .padding(EdgeInsets(top: 30, leading: 30, bottom: 15, trailing: 30))
        .navigationBarHidden(true)
    }
}

//
//struct MissionResultView_Previews: PreviewProvider {
//    static var previews: some View {
//        MissionResultModalView(tag: )
//    }
//}

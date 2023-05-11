//
//  WorkoutDoneView.swift
//  BurningBuddy
//
//  Created by 김동현 on 2023/05/04.
//

import Foundation
import SwiftUI
/**
 파트너의 데이터모델을 들고 오는 것이 필요.
 만약 데이터가 없거나, 목표 달성을 하지 못한 것이 감지되는 경우,
 MissionModal을 띄워줘야 한다. 이 로직은 목표달성 확인하기 button action에서 해야 한다.
 단, 길어질 경우, 새로운 메서드 안에서 이 과정을 실행해야 한다.
 */
struct WorkoutDoneView: View {
    @EnvironmentObject var settings: UserSettings
    @State var isNotDoneWorkoutPopup = false
    @State private var tag: Int? = nil
    
    var body: some View {
        VStack {
            Text("\(settings.nickName)님")
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.white)
                .font(.system(size: 21, weight: .bold))
            Text("수고하셨어요!")
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.white)
                .font(.system(size: 28, weight: .bold))
            Text("애플워치 운동기록을 종료하신 후\n오늘 함께 운동한 파트너와\n디바이스를 접촉해주세요!")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(EdgeInsets(top: 1, leading: 0, bottom: 0, trailing: 0))
                .font(.system(size: 17, weight: .regular, design: .default))
                .lineSpacing(TextUtil().calculateLineSpacing(17, 143.5))
            
            Spacer()
            ZStack {
                Image(systemName: "hands.sparkles.fill")
                    .resizable()
                    .frame(width: 189, height: 189)
                    .foregroundColor(Color.bunnyColor)
            }
            Spacer()
            if settings.isDoneTogetherWorkout {
                NavigationLink(destination: WorkoutSuccessView(), tag: 1, selection: self.$tag) { // destination이 달라야 한다. 모달이 뜨기 전에 화면 이동이 될 수도 있다.
                    Text("목표달성 확인하기")
                }
                .buttonStyle(RedButtonStyle())
                Button(action: {
//                    self.tag = 1
                }) {
                    EmptyView()
                }
            } else {
                NavigationLink(destination: WorkoutFailView(), tag: 0, selection: self.$tag) { // destination이 달라야 한다. 모달이 뜨기 전에 화면 이동이 될 수도 있다.
                    Text("목표달성 확인하기")                }
                .buttonStyle(RedButtonStyle())
                Button(action: {
                    isNotDoneWorkoutPopup = true
                }) {
                    EmptyView()
                }
            }
           
        }
        .padding(EdgeInsets(top: 10, leading: 30, bottom: 15, trailing: 30)) // 전체 아웃라인
        .background(Color(red: 30/255, green: 28/255, blue: 29/255))
        .sheet(isPresented: self.$isNotDoneWorkoutPopup) {
            if #available(iOS 16.0, *) {
                MissionResultModalView(title: "아직 목표량을 채우지 못했어요", article: "그래도 운동을 종료하시겠어요?", leftButtonName: "더 해볼께요", rightButtonName: "그만할래요", tag: $tag)
                // 하위 모달에서 상위 뷰에 값을 전달해야 한다. leftbutton, rightbutton 각각을 눌렀을 때 다른 값을 1, 2를 전달해야 한다.
                    .presentationDetents([.fraction(0.4)])
                    .background(Color(red: 30/255, green: 28/255, blue: 29/255))
            } else {
                // Fallback on earlier versions
                MissionResultModalView(title: "아직 목표량을 채우지 못했어요", article: "그래도 운동을 종료하시겠어요?", leftButtonName: "더 해볼께요", rightButtonName: "그만할래요", tag: $tag)
                    .background(Color(red: 30/255, green: 28/255, blue: 29/255))
            }
        }
    }
}


struct WorkoutDoneView_Previews: PreviewProvider {
    
    static var previews: some View {
        WorkoutDoneView()
            .environmentObject(UserSettings())
    }
}


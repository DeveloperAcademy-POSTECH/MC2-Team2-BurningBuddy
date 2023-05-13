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
 
 isDoneTogetherWorkout 변수를 settings에서 달성 여부를 판단해서 가지고 있어야 한다.
 
 */
struct WorkoutDoneView: View {
    @EnvironmentObject var settings: UserSettings
    @State var isNotDoneWorkoutPopup = false
    @State private var isSuccessNext: Bool = false
    @Binding var mainViewNavLinkActive: Bool
    
    @StateObject private var niObject = NISessionManager()
    @State private var isLaunched = true
    @State var isLocalNetworkPermissionDenied = false
    @State private var checkPartner: Bool = false
    @State var isDataReceived: Bool = false
    private let localNetAuth = LocalNetworkAuthorization()
    
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
            NavigationLink(isActive: $isSuccessNext, destination: {
                if settings.isDoneTogetherWorkout {
                    WorkoutSuccessView(mainViewNavLinkActive: $mainViewNavLinkActive)
                } else {
                    WorkoutFailView(mainViewNavLinkActive: $mainViewNavLinkActive)
                }
                
            }, label: {
                Button("목표달성 확인하기") {
                    print("Navi link 안")
                    
                    // TODO: DataReeiveView를 만들어준다 -> 모달 뷰(DataReeiveView) 띄우기 -> 상대방 데이터 통신 -> 모달 뷰 해제
                    
                    self.checkPartner = true // 모달뷰 띄우기
                    if niObject.isBumped {
                        self.checkPartner = false
                        if !niObject.isDoneTargetCalories || UserDefaults.standard.bool(forKey: "isDoneWorkout") { // isDoneWorkout: 목표달성 여부 체크 부울값
                            self.isNotDoneWorkoutPopup = true
                        } else {
                            self.isSuccessNext = true
                        }
                    }
                    
                    
                    // print("niObject에 저장된 상대방 id", niObject.bumpedID?.uuidString ?? "값 없음")
                    // print("userDefalut에 저장된 상대방 id", UserDefaults.standard.string(forKey: "partnerID") ?? "값 없음")
                    // 다음 뷰로 넘어가는 변수
                }
                .fullScreenCover(isPresented: self.$checkPartner, content: {
                    // 상대방이 운동을 달성했는지 확인하는 부분
                    DataReceiveView(niObject: niObject, isDataReceived: $isSuccessNext, checkPartner: $checkPartner) // TODO: - niObject가 같은 변수를 공유하는지 확인하기 - 잘 돌아간다고 치고
                        .environmentObject(settings)
                })
                
                .buttonStyle(RedButtonStyle())
            })
        }
        
        .padding(EdgeInsets(top: 50, leading: 30, bottom: 15, trailing: 30)) // 전체 아웃라인
        .background(Color(red: 30/255, green: 28/255, blue: 29/255))
        .sheet(isPresented: self.$isNotDoneWorkoutPopup) {
            if #available(iOS 16.0, *) {
                MissionResultModalView(title: "파트너가 아직 운동 중이에요!", article: "운동을 마칠 때까지 응원해주세요!", leftButtonName: "알겠어요", rightButtonName: "그만할래요", wantQuitWorkout: $isSuccessNext )
                    .presentationDetents([.fraction(0.4)])
                    .background(Color(red: 30/255, green: 28/255, blue: 29/255))
                    .environmentObject(settings)
                //  TODO: - 수정
            }
        }
        .navigationBarHidden(true)
    }
    
    
    
    
    //  private func getDestination() -> some View {
    //    startNI()
    //    // peer의 uuid가 저장되어있는 settings.partnerID와 일치하는지 확인
    //    if settings.isDoneTogetherWorkout {
    //      return AnyView(WorkoutSuccessView(mainViewNavLinkActive: $mainViewNavLinkActive))
    //    }
    //    else {
    //      return AnyView(WorkoutFailView(mainViewNavLinkActive: $mainViewNavLinkActive))
    //    }
    //  }
}

//
//struct WorkoutDoneView_Previews: PreviewProvider {
//    
//    static var previews: some View {
//        WorkoutDoneView()
//            .environmentObject(UserSettings())
//    }
//}


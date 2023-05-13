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
    @State private var isFailWorkout: Bool = false
    @State private var isSuccessWorkout: Bool = false
    @State private var isSuccessNext: Bool = false
    @State private var isFailNext: Bool = false
    @Binding var mainViewNavLinkActive: Bool
    
    @StateObject private var niObject = NISessionManager()
    @State private var isLaunched = true
    @State var isLocalNetworkPermissionDenied = false
    
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
//<<<<<<< HEAD
////            if settings.isDoneTogetherWorkout {
//                NavigationLink(destination: getDestination()) { // destination이 달라야 한다. 모달이 뜨기 전에 화면 이동이 될 수도 있다.
//                    Text("목표달성 확인하기")
//                }
//                .buttonStyle(RedButtonStyle())
//                Button(action: {
////                    self.tag = 1
//
//                    // TODO: - 루나웨스트 NISession 연결 후, 연결된 peer의 uuid가 저장되어있는 settings.partnerID와 일치하는지 확인
//                }) {
//                    EmptyView()
//                }
////            } else {
////                NavigationLink(destination: WorkoutFailView(), tag: 0, selection: self.$tag) { // destination이 달라야 한다. 모달이 뜨기 전에 화면 이동이 될 수도 있다.
////                    Text("목표달성 확인하기")                }
////                .buttonStyle(RedButtonStyle())
////                Button(action: {
////                    // TODO: - 루나웨스트 NISession 연결 후, peer의 uuid가 저장되어있는 settings.partnerID와 일치하는지 확인
////                    // 일치하면 isDoneTogetherWorkout을 true로 변경
////                    isNotDoneWorkoutPopup = true
////                }) {
////                    EmptyView()
////                }
////            }
//=======
            if settings.isDoneTogetherWorkout {
                NavigationLink(isActive: $isSuccessNext, destination: {
                  getDestination()
                }, label: {
                    Button("목표달성 확인하기") {
                        print("Navi link 안")
                        self.isSuccessNext = true
                    }.buttonStyle(RedButtonStyle())
                })
            } else {
                NavigationLink(isActive: $isFailNext, destination: {
                  getDestination() // TODO: 중복 코드 제거
                }, label: {
                    Button("목표달성 확인하기") {
                        // 목표량 달성 여부 확인 메서드 필요한 곳
                        self.isNotDoneWorkoutPopup = true
                        print("Navi link 안")
                    }.buttonStyle(RedButtonStyle())
                })
            }
//>>>>>>> 508c671cced6921d12b6a0a2a70fcc14aa70b4d6
           
        }
        .padding(EdgeInsets(top: 50, leading: 30, bottom: 15, trailing: 30)) // 전체 아웃라인
        .background(Color(red: 30/255, green: 28/255, blue: 29/255))
        .sheet(isPresented: self.$isNotDoneWorkoutPopup) {
            if #available(iOS 16.0, *) {
              MissionResultModalView(title: "파트너가 아직 운동 중이에요!", article: "운동을 마칠 때까지 응원해주세요!", leftButtonName: "", rightButtonName: "알겠어요", wantQuitWorkout: $isFailNext )
                    .presentationDetents([.fraction(0.4)])
                    .background(Color(red: 30/255, green: 28/255, blue: 29/255))
                    .environmentObject(settings)
              //  TODO: - 수정
            }
        }
        .navigationBarHidden(true)
    }
    
    private func startNI() {
        switch niObject.findingPartnerState {
        case .ready:
            niObject.start()
            niObject.findingPartnerState = .finding
            if isLaunched {
                localNetAuth.requestAuthorization { auth in
                    isLocalNetworkPermissionDenied = !auth
                }
                isLaunched = false
            }
        case .finding:
            niObject.stop()
            niObject.findingPartnerState = .ready
        case .found:
          if niObject.bumpedID == settings.partnerID {
            settings.isDoneTogetherWorkout = true
          } else {
            settings.isDoneTogetherWorkout = false
          }
            niObject.stop()
            niObject.findingPartnerState = .ready
        }
    }
  
  private func getDestination() -> AnyView {
    startNI()
    // peer의 uuid가 저장되어있는 settings.partnerID와 일치하는지 확인
    if settings.isDoneTogetherWorkout {
      return AnyView(WorkoutSuccessView(mainViewNavLinkActive: $mainViewNavLinkActive))
    }
    else {
      return AnyView(WorkoutFailView(mainViewNavLinkActive: $mainViewNavLinkActive))
    }
  }
}

//
//struct WorkoutDoneView_Previews: PreviewProvider {
//    
//    static var previews: some View {
//        WorkoutDoneView()
//            .environmentObject(UserSettings())
//    }
//}


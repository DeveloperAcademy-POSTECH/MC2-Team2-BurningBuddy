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
            AnyView(setTitleText()) // 타이틀, 텍스트
            Spacer()
            ZStack {
                if !niObject.isBumped {
                    switch(niObject.findingPartnerState) {
                    case .finding, .found:
                        LoadingAnimationView()
                    case .ready:
                        Image(systemName: "iphone.gen3.radiowaves.left.and.right")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 215)
                            .foregroundColor(Color.bunnyColor)
                    }
                }
                else {
                    Image(systemName: "hands.sparkles.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 189)
                        .foregroundColor(Color.bunnyColor)
                }
            }
            Spacer()
            switch(niObject.isBumped) {
                
            case true:
                NavigationLink(isActive: $isSuccessNext, destination: {
                    
                    
                    if niObject.bumpedIsDoneTargetCalories && UserDefaults.standard.bool(forKey: "isDoneWorkout") {
                        WorkoutSuccessView(mainViewNavLinkActive: $mainViewNavLinkActive)
                    } else {
                        WorkoutFailView(mainViewNavLinkActive: $mainViewNavLinkActive)
                    }
                    
                }, label: {
                    Button("목표달성 확인하기") {
                        if niObject.bumpedIsDoneTargetCalories && UserDefaults.standard.bool(forKey: "isDoneWorkout") {
                            self.settings.isDoneTogetherWorkout = true
                            print("상대방이 목표를 달성했어요!")
                            isNotDoneWorkoutPopup = false
                            isSuccessNext = true // TODO: 다음 페이지로 넘어가야 함
                            
                        } else {
                            self.settings.isDoneTogetherWorkout = false
                            isNotDoneWorkoutPopup = true
                            
                        }
                        print("상대방의 목표 달성 확인하기: \(niObject.bumpedIsDoneTargetCalories)")
                        // 데이터 통신부분은 해결-> 상대방이 목표칼로리에 도달했는지 안했는지가 반영이 안되어있던거였음
                        // TODO: 목표달성 확인하기를 누르면 "상대방이 목표를 달성했어요!"는 print 잘되는데 다음 페이지로 안넘어감
                        
                    }
                    .buttonStyle(RedButtonStyle())
                })
            case false:
                switch (niObject.findingPartnerState) {
                case .ready:
                    //            NavigationLink(isActive: $isSuccessNext, destination: {
                    //              if settings.isDoneTogetherWorkout { // TODO: settings.isDoneTogetherWorkout에 관한 변수를 잘 설정해야 함
                    //                WorkoutSuccessView(mainViewNavLinkActive: $mainViewNavLinkActive)
                    //              } else {
                    //                WorkoutFailView(mainViewNavLinkActive: $mainViewNavLinkActive)
                    //              }
                    //
                    //            }, label: {
                    Button("파트너 연결하기") {
                        // NIObject 통신 시작
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
                            niObject.stop()
                            niObject.findingPartnerState = .ready
                        }
                    }
                    .buttonStyle(RedButtonStyle())
                    //            }) // Buggon end
                case .finding, .found:
//                    NavigationLink(isActive: $isSuccessNext, destination: {
//                        if settings.isDoneTogetherWorkout {
//                            WorkoutSuccessView(mainViewNavLinkActive: $mainViewNavLinkActive)
//                        } else {
//                            WorkoutFailView(mainViewNavLinkActive: $mainViewNavLinkActive)
//                        }
//
//                    }, label: {
                        Button("파트너 연결 취소하기") {
                            // NIObject 통신 시작
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
                                niObject.stop()
                                niObject.findingPartnerState = .ready
                            }
                        }
                        .buttonStyle(RedButtonStyle())
//                    }) // Button end
                }
            } // switch 끝
        }
        
        .padding(EdgeInsets(top: 50, leading: 30, bottom: 15, trailing: 30)) // 전체 아웃라인
        .background(Color(red: 30/255, green: 28/255, blue: 29/255))
        .sheet(isPresented: self.$isNotDoneWorkoutPopup) {
            if #available(iOS 16.0, *) {
                MissionResultModalView(title: "파트너가 아직 운동 중이에요!", article: "운동을 마칠 때까지 응원해주세요!", leftButtonName: "알겠어요", rightButtonName: "그만할래요", wantQuitWorkout: $isSuccessNext )
                    .presentationDetents([.fraction(0.4)])
                    .background(Color(red: 30/255, green: 28/255, blue: 29/255))
                    .environmentObject(settings)
                    .onDisappear {
                        niObject.isBumped = false
                    }
            }
        }
        .navigationBarHidden(true)
    } // body End
}

extension WorkoutDoneView {
    // 상태에 따라 타이틀과 설명 Text그리는 함수
    private func setTitleText() -> any View {
        if !niObject.isBumped {
            switch(niObject.findingPartnerState) {
            case .ready:
                return VStack {
                    Text("\(settings.nickName)님")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(.white)
                        .font(.system(size: 21, weight: .bold))
                    Text("수고하셨어요! 🥇")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(.white)
                        .font(.system(size: 28, weight: .bold))
                    Text("애플워치 운동기록을 종료하신 후,\n오늘 함께 운동한 파트너와\n목표달성 여부를 공유해보세요")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(EdgeInsets(top: 1, leading: 0, bottom: 0, trailing: 0))
                        .font(.system(size: 17, weight: .regular, design: .default))
                        .lineSpacing(TextUtil().calculateLineSpacing(17, 143.5))
                }
            case .finding, .found:
                return VStack {
                    Text("내 파트너를\n찾는 중이에요")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(.white)
                        .font(.system(size: 28, weight: .bold))
                    Text("서로의 휴대폰을 가까이 붙여주세요")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(EdgeInsets(top: 1, leading: 0, bottom: 0, trailing: 0))
                        .font(.system(size: 17, weight: .regular, design: .default))
                        .lineSpacing(TextUtil().calculateLineSpacing(17, 143.5))
                }
            }
        }
        else {
            switch(niObject.findingPartnerState) {
            case .ready:
                return VStack {
                    Text("파트너와\n연결 완료!")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(.white)
                        .font(.system(size: 28, weight: .bold))
                    Text("파트너와 내가 목표달성에\n성공했는지 확인해보세요!")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(EdgeInsets(top: 1, leading: 0, bottom: 0, trailing: 0))
                        .font(.system(size: 17, weight: .regular, design: .default))
                        .lineSpacing(TextUtil().calculateLineSpacing(17, 143.5))
                }
            default:
                return Text("케이스 해당 없음")
            }
        }
    }
}


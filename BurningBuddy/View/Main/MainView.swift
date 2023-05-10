//
//  MainView.swift
//  BurningBuddy
//
//  Created by 김동현 on 2023/05/02.
//

import Foundation
import SwiftUI
/**
 settings에 있는 것을 그대로 보여주기만 하면 된다.
 progress 바 안의 변수를 조금 수정해주긴 해야 한다.
 Color asset 처리가 필요.
 중복되는 Text 컴포넌트, 메서드 처리할까?
 */
struct MainView: View {
    @EnvironmentObject var settings: UserSettings
    @State var daysleft: Int = 0
    @State var showEvolution = false // 진화과정 모달에 관련된 상태
  
//  @StateObject var niObject = NISessionManager()
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    HStack {
                        Text(settings.nickName)
                            .font(.system(size: 25, weight: .bold, design: .default))
                        Text("님의")
                            .font(.system(size: 25, design: .default))
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        Spacer()
                        NavigationLink(destination: {
                            SettingView()
                                .environmentObject(settings)
                        }) {
                            Image(systemName: "person.circle")
                                .resizable()
                                .frame(width: 32, height: 32)
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        }
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text(settings.characterName)
                        .foregroundColor(.white)
                        .font(.system(size: 30, weight: .bold, design: .default))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(EdgeInsets(top: -13, leading: 0, bottom: 0, trailing: 0))
                    
                    HStack {
                        Image(systemName: "dumbbell.fill")
                            .resizable()
                            .frame(width: 34, height: 25)
                            .rotationEffect(Angle(degrees: -45))
                        Text("다음 성장까지")
                            .font(.system(size: 20, design: .default))
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: -3))
                        Text("\(daysleft)번")
                            .font(.system(size: 20, weight: .bold, design: .default))
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: -3))
                        Text("남았어요!")
                            .font(.system(size: 20, design: .default))
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    }.frame(maxWidth: .infinity, alignment: .leading)
                        .padding(EdgeInsets(top: 5, leading: 0, bottom: -5, trailing: 0))
                }
                
                ProgressView(value: Double(settings.totalDumbbell), total: 66)
                    .scaleEffect(x: 1, y: 2, anchor: .center)
                    .progressViewStyle(LinearProgressViewStyle(tint: Color(red: 255/255, green: 45/255, blue: 85/255)))
                    .padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
                    
                Spacer()
                VStack {
                    HStack {
                        Button("", action: {
                            
                            self.showEvolution = true
                        })
                        Image(systemName: "info.circle")
                            .resizable()
                            .frame(width: 20, height: 20)
                        .fullScreenCover(isPresented: self.$showEvolution, content: {
                            LevelUpModalView()
                        })
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(EdgeInsets(top: 20, leading: 0, bottom: -40, trailing: 20))
                    Circle()
                        .frame(width: 200, height: 250)
                        .scaledToFill()
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                }
                .background(Color(red: 40/255, green: 48/255, blue: 49/255))
                .cornerRadius(20)
                .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
                
                VStack {
                    Text("오늘의 운동량")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size: 18, weight: .semibold, design: .default))
                        .padding(EdgeInsets(top: 17, leading: 17, bottom: 0, trailing: 17))
                    HStack {
                        VStack {
                            Spacer()
                            Text("🔥")
                                .font(.system(size: 20, design: .default))
                            Spacer()
                            Text("소모 칼로리")
                                .font(.system(size: 20, design: .default))
                            Spacer()
                            Text(settings.isDoneWorkout ? String(settings.todayCalories) : "오늘 안함")
                                .font(.system(size: 25, weight: .bold, design: .default))
                            Spacer()
                        }
                        .frame(maxWidth: .infinity,  maxHeight: .infinity, alignment: .center)
                        .background(Color(red: 72/255, green: 72/255, blue: 74/255))
                        .cornerRadius(20)
                        
                        VStack {
                            Spacer()
                            Text("⏱️")
                                .font(.system(size: 20, design: .default))
                            Spacer()
                            Text("운동 시간")
                                .font(.system(size: 20, design: .default))
                            Spacer()
                            Text(settings.isDoneWorkout ? settings.totalWorkoutTime : "오늘 안함")
                                .font(.system(size: 25, weight: .bold, design: .default))
                            Spacer()
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                        .background(Color(red: 72/255, green: 72/255, blue: 74/255))
                        .cornerRadius(20)
                    }
                    .padding(EdgeInsets(top: 2, leading: 17, bottom: 10, trailing: 17))
                    Spacer()
                }
                .background(Color(red: 40/255, green: 48/255, blue: 49/255))
                .cornerRadius(20)
                .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
                Spacer()
                Spacer()
                NavigationLink(destination: {
                    if settings.hasPartner {
                        WorkoutView().environmentObject(settings)
                    } else {
                      SearchPartnerView()
                          .environmentObject(settings)
//                          .environmentObject(niObject)
                    // niObject.findingPartnerState = .ready 초기화
                    }
                }) {
                    Text(settings.hasPartner ? "운동 종료하기" : "운동 시작하기")
                }
                .buttonStyle(RedButtonStyle())
//                .simultaneousGesture(TapGesture().onEnded{
//                  niObject.findingPartnerState = .ready
//                })
            }
            .padding(EdgeInsets(top: 50, leading: 30, bottom: 30, trailing: 30))
            .background(Color(red: 30/255, green: 28/255, blue: 29/255))
        }
    } // body End
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView().environmentObject(UserSettings())
            .preferredColorScheme(.dark)
    }
}

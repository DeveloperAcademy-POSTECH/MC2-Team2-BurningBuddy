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
    @State var showEvolution = false // 진화과정 모달에 관련된 상태
    @State var mainViewNavLinkActive: Bool = false
    @State private var showOnboarding: Bool = UserDefaults.standard.bool(forKey: "showOnboarding")
    
    //앱이 종료될 때 현재 날짜를 기록하고, 다음에 앱이 실행될 때 해당 날짜와 비교하여 데이터를 초기화하는 방법
    private let lastLaunchDateKey = "lastLaunchDate" // 마지막으로 앱을 종료했을때의 날짜
    let formatter = DateFormatter()
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    HStack {
                        Text(settings.nickName)
                            .font(.system(size: 22, weight: .bold, design: .default))
                        Text("님의")
                            .font(.system(size: 22, design: .default))
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
                                .foregroundColor(Color.iconColor)
                        }
                    }
                    .foregroundColor(Color.mainTextColor)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text(settings.characterName)
                        .foregroundColor(Color.mainTextColor)
                        .font(.system(size: 30, weight: .bold, design: .default))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(EdgeInsets(top: -13, leading: 0, bottom: 0, trailing: 0))
                    
                    HStack {
                        Image(systemName: "dumbbell.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 27, height: 25)
                            .rotationEffect(Angle(degrees: -45))
                            .foregroundColor(Color.bunnyColor)
                        Text("다음 성장까지")
                            .font(.system(size: 18, design: .default))
                            .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: -3))
                        Text("\(countRemainDumbbell(presentLevel: settings.level))번")
                            .font(.system(size: 18, weight: .bold, design: .default))
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: -3))
                        Text("남았어요!")
                            .font(.system(size: 18, design: .default))
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    }.frame(maxWidth: .infinity, alignment: .leading)
                        .padding(EdgeInsets(top: 5, leading: 0, bottom: -5, trailing: 0))
                }
                
                ProgressView(value: Double(settings.totalDumbbell), total: 66)
                    .scaleEffect(x: 1, y: 2, anchor: .center)
                    .progressViewStyle(LinearProgressViewStyle(tint: Color(red: 255/255, green: 45/255, blue: 85/255)))
                    .padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
                
                Spacer()
                Spacer()
                VStack {
                    Spacer()
                    HStack {
                        Button(action: {
                            self.showEvolution = true
                        }, label: {
                            Image(systemName: "info.circle")
                                .resizable()
                                .foregroundColor(Color.iconColor)
                                .frame(width: 20, height: 20)
                        })
                        .fullScreenCover(isPresented: self.$showEvolution, content: {
                            LevelUpModalView()
                                .environmentObject(settings)
                        })
                        .foregroundColor(Color.iconColor)
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: -40, trailing: 20))
                    //                    Circle()
                    //                        .frame(width: 200, height: 250)
                    //                        .scaledToFill()
                    //                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    
                    
                    Image("Bunny_\(settings.level)_front")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 315)
                    
                    Spacer()
                }
                .background(Color.mainSection)
                .cornerRadius(12)
                .padding(EdgeInsets(top: 10, leading: 0, bottom: -40, trailing: 0))
                //여기가 캐릭터 칸 크기 조절할 수 있는 코드
                
                Spacer()
                VStack {
                    Text("오늘의 운동량")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size: 18, weight: .semibold, design: .default))
                        .padding(EdgeInsets(top: 17, leading: 17, bottom: 0, trailing: 17))
                    HStack {
                        VStack {
                            Text("🔥")
                                .font(.system(size: 20, design: .default))
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 1, trailing: 0))
                            Text("소모 칼로리")
                            
                                .font(.system(size: 15, weight: .semibold))
                                .foregroundColor(Color.subTextColor)
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 1, trailing: 0))
                            Text(UserDefaults.standard.bool(forKey: "isDoneWorkout") ? String(settings.workoutData.workoutCalorie) : "k")
                                .font(.system(size: 24, weight: .bold, design: .default))
                                .foregroundColor(Color.mainTextColor)
                        }
                        .frame(maxWidth: .infinity,  maxHeight: .infinity, alignment: .center)
                        .background(Color.mainSection2)
                        .cornerRadius(12)
                        
                        VStack {
                            Text("⏱️")
                                .font(.system(size: 20, design: .default))
                            
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 1, trailing: 0))
                            Text("운동 시간")
                                .font(.system(size: 15, weight: .semibold))
                                .foregroundColor(Color.subTextColor)
                            
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 1, trailing: 0))
                            
                            Text(UserDefaults.standard.bool(forKey: "isDoneWorkout") ?  String(settings.workoutData.workoutDuration) : "00h 00m")
                                .font(.system(size: 24, weight: .bold, design: .default))
                                .foregroundColor(Color.mainTextColor)
                            
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                        .background(Color.mainSection2)
                        .cornerRadius(12)
                    }
                    .padding(EdgeInsets(top: 2, leading: 17, bottom: 5, trailing: 17))
                    Spacer()
                }
                .background(Color.mainSection)
                .cornerRadius(12)
                .padding(EdgeInsets(top: 50, leading: 0, bottom: 10, trailing: 0))
                //여기가 오늘의 운동량 크기 조절할 수 있는 코드
                Spacer()
                Spacer()
                if UserDefaults.standard.bool(forKey: "isWorkouting") {
                    NavigationLink(
                        destination: WorkoutView(mainViewNavLinkActive: $mainViewNavLinkActive).environmentObject(settings),
                        isActive: $mainViewNavLinkActive,
                        label: {
                            Text("운동화면 보기")
                        })
                    .buttonStyle(RedButtonStyle())
                } else {
                    NavigationLink(
                        destination: SearchPartnerView(mainViewNavLinkActive: $mainViewNavLinkActive).environmentObject(settings),
                        isActive: $mainViewNavLinkActive,
                        label: {
                            Text("파트너와 연결하기")
                        })
                    .buttonStyle(RedButtonStyle())
                }
            }
            .padding(EdgeInsets(top: 20, leading: 30, bottom: 15, trailing: 30))
            .background(Color.backgroundColor)
            .navigationBarTitle("")
            
        }
        .onAppear{
            settings.workoutData.requestAuthorization()
            // 날이 바꼈으면 userdefault의 값 초기화하기 & CoreData의 todayWorkoutHours, todayWorkoutHours 초기화
            if let lastLaunchDate = UserDefaults.standard.object(forKey: lastLaunchDateKey) as? Date {
                // 앱을 마지막으로 종료한 날짜와 오늘 켠 날짜가 같은 날이 아니라면? 데이터들을 초기화
                if !isSameDay(date1: lastLaunchDate, date2: Date()) {
                    resetData()
                }
            } else {
                resetData()
            }
            
            // 가장 최근에 앱을 켠 날짜를 기록해줌
            UserDefaults.standard.set(Date(), forKey: lastLaunchDateKey)
        }
        .accentColor(Color.mainTextColor)
        
    } // body End
    
    private func countRemainDumbbell(presentLevel: Int16) -> Int16 {
        let targetLevel: Int16 = presentLevel + 1
        var remainDumbbell: Int16 = 0
        switch targetLevel {
        case 2:
            remainDumbbell = 3 - self.settings.totalDumbbell
        case 3:
            remainDumbbell = 7 - self.settings.totalDumbbell
        case 4:
            remainDumbbell = 21 - self.settings.totalDumbbell
        case 5:
            remainDumbbell = 30 - self.settings.totalDumbbell
        case 6:
            remainDumbbell = 45 - self.settings.totalDumbbell
        default:
            remainDumbbell = 66 - self.settings.totalDumbbell
        }
        return remainDumbbell
    }
    
    // 날짜(년, 월, 일)가 같은지 check
    private func isSameDay(date1: Date, date2: Date) -> Bool {
        let calendar = Calendar.current
        let components1 = calendar.dateComponents([.year, .month, .day], from: date1)
        let components2 = calendar.dateComponents([.year, .month, .day], from: date2)
        
        return components1.year == components2.year && components1.month == components2.month && components1.day == components2.day
    }
    
    
    private func resetData() {
        UserDefaults.standard.set(false, forKey: "isWorkouting")
        UserDefaults.standard.set(false, forKey: "isDoneWorkout")
        UserDefaults.standard.set("", forKey: "partnerID")
        
        CoreDataManager.coreDM.readAllUser()[0].todayCalories = 0
        CoreDataManager.coreDM.readAllUser()[0].todayWorkoutHours = "00h 00m"
        CoreDataManager.coreDM.update()
        settings.isDoneTogetherWorkout = false
    }
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(UserSettings())
            .preferredColorScheme(.dark)
    }
}

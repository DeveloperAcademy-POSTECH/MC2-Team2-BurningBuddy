//
//  MainView.swift
//  BurningBuddy
//
//  Created by 김동현 on 2023/05/02.
//

import Foundation
import SwiftUI


struct MainView: View {
    @ObservedObject var userModel: UserModel
    @ObservedObject var bunnyModel: BunnyModel
    @ObservedObject var workoutModel: WorkoutModel
    @ObservedObject var healthData = HealthData()
    
    @State var showEvolution = false // 진화과정 모달에 관련된 상태
    @State var mainViewNavLinkActive: Bool = false
    @State private var showOnboarding: Bool = UserDefaults.standard.bool(forKey: "showOnboarding")
    
    //TODO: -
    /**
     8/15
     마지막으로 앱을 종료했을 때 날짜를 기준으로 기록할 필요가 현재는 있음(8/21일 수정)
     CoreData에서 Column 관리를 해주면 됨.
     또한 운동 기록을 계속 쌓는 방식으로 CoreData 구조를 변경해야 함.
     settings를 걷어내고, DataModel 방식으로 데이터를 불러오는 구조 필요.
     showOnboarding도 AppStorage 활용하여 변경하는 것 필요.
     */
    //앱이 종료될 때 현재 날짜를 기록하고, 다음에 앱이 실행될 때 해당 날짜와 비교하여 데이터를 초기화하는 방법
    private let lastLaunchDateKey = "lastLaunchDate" // 마지막으로 앱을 종료했을때의 날짜
    let formatter = DateFormatter()
    
    var body: some View {
        
        //TODO: -
        /**
         8/15
         레이아웃 변경 필요. (EdgeInsets 제거, stack에 spacing: 0 추가 등)
         extension 메서드로 코드 분할하는 것도 생각해보기.
         */
        NavigationView {
            VStack {
                VStack {
                    HStack {
                        Text(userModel.userName)
                            .font(.system(size: 22, weight: .bold, design: .default))
                        Text("님의")
                            .font(.system(size: 22, design: .default))
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        Spacer()
                        NavigationLink(destination: {
                            SettingView(userModel: userModel, bunnyModel: bunnyModel)
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
                    
                    Text(bunnyModel.bunnyName)
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
                        Text("\(countRemainDumbbell(presentLevel: Int16(bunnyModel.bunnyLevel)))번")
                            .font(.system(size: 18, weight: .bold, design: .default))
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: -3))
                        Text("남았어요!")
                            .font(.system(size: 18, design: .default))
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    }.frame(maxWidth: .infinity, alignment: .leading)
                        .padding(EdgeInsets(top: 5, leading: 0, bottom: -5, trailing: 0))
                }
                
                ProgressView(
                    value: Double(progressbarGetDumbbell(presentDumbbell: Int(userModel.totalDumbbell))),
                    total: Double(progressbarRemain(presentDumbbell: Int16(userModel.totalDumbbell)))
                )
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
                            print("showEvolution click")
                        }, label: {
                            Image(systemName: "info.circle")
                                .resizable()
                                .foregroundColor(Color.iconColor)
                                .frame(width: 20, height: 20)
                        })
                        .fullScreenCover(isPresented: self.$showEvolution, content: {
                            LevelUpModalView(userModel: userModel, bunnyModel: bunnyModel)
                        })
                        .foregroundColor(Color.iconColor)
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 20))
                    
                    Image("Bunny_\(bunnyModel.bunnyLevel)_front")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300)
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
                            Text(UserDefaults.standard.bool(forKey: "isDoneWorkout") ? "\(userModel.todayCalories)kcal" : "0kcal")
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
                            Text(UserDefaults.standard.bool(forKey: "isDoneWorkout") ? userModel.calculateTime(second: TimeInterval(userModel.todayWorkoutHours)) : "00h 00m")
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
                
                // TODO: -
                /**
                 isactive 인자로 하는 것 말고, 다른 것으로 변경
                 isWorkouting도 AppStorage 또는 다른 것으로 변경하여야 함.\
                 또한 운동화면 보기, 파트너와 연결하기 이외에, 운동이 끝나고 나서 종료했을 경우 또는 앱 오류로 인해 종료되는 것을 고려하여
                 "파트너와 운동 기록 공유하기" 버튼을 두어야 함.
                 */
                if UserDefaults.standard.bool(forKey: "isWorkouting") {
                    NavigationLink(
                        destination: WorkoutView(userModel: userModel, bunnyModel: bunnyModel, workoutModel: workoutModel, healthData: healthData, mainViewNavLinkActive: $mainViewNavLinkActive),
                        isActive: $mainViewNavLinkActive,
                        label: {
                            Text("운동화면 보기")
                        })
                    .buttonStyle(BurningBuddyButton(style: .red))
                } else {
//                    NavigationLink(
//                        destination: SearchPartnerView(userModel: userModel, bunnyModel: bunnyModel, workoutModel: workoutModel, healthData: healthData, mainViewNavLinkActive: $mainViewNavLinkActive),
//                        isActive: $mainViewNavLinkActive,
//                        label: {
//                            Text("파트너와 연결하기")
//                        })
//                    .buttonStyle(BurningBuddyButton(style: .red))
                    NavigationLink(
                        destination: ModeSelectionView(userModel: userModel, bunnyModel: bunnyModel, workoutModel: workoutModel),
                        isActive: $mainViewNavLinkActive,
                        label: {
                            Text("운동 시작하기")
                        })
                    .buttonStyle(BurningBuddyButton(style: .red))
                }
            }
            .padding(EdgeInsets(top: 20, leading: 30, bottom: 15, trailing: 30))
            .background(Color.backgroundColor)
            .navigationBarTitle("")
            
        }
        .onAppear{
            healthData.requestAuthorization()
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
    
    // TODO: -
    /**
     이하의 메서드들은 MainView에 있어야 할 메서드가 아님.
     Util 역할을 하는 메서드들로, Util 클래스를 두는 방식으로 분리하는 것이 필요.
     */
    private func countRemainDumbbell(presentLevel: Int16) -> Int16 {
        let targetLevel: Int16 = presentLevel + 1
        var remainDumbbell: Int16 = 0
        switch targetLevel {
        case 2:
            remainDumbbell = Int16(3 - self.userModel.totalDumbbell)
        case 3:
            remainDumbbell = Int16(7 - self.userModel.totalDumbbell)
        case 4:
            remainDumbbell = Int16(21 - self.userModel.totalDumbbell)
        case 5:
            remainDumbbell = Int16(30 - self.userModel.totalDumbbell)
        case 6:
            remainDumbbell = Int16(45 - self.userModel.totalDumbbell)
        default:
            remainDumbbell = Int16(66 - self.userModel.totalDumbbell)
        }
        return remainDumbbell
    }
    
    private func progressbarRemain(presentDumbbell: Int16) -> Int {
        switch presentDumbbell {
        case ..<3:
            return 3
        case ..<7:
            return 4
        case ..<21:
            return 14
        case ..<30:
            return 9
        case ..<45:
            return 15
        default:
            return 22
        }
    }
    
    private func progressbarGetDumbbell(presentDumbbell: Int) -> Int {
        switch presentDumbbell {
        case ..<3:
            return presentDumbbell
        case ..<7:
            return presentDumbbell - 3
        case ..<21:
            return presentDumbbell - 7
        case ..<30:
            return presentDumbbell - 21
        case ..<45:
            return presentDumbbell - 30
        default:
            return presentDumbbell - 45
        }
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
        UserDefaults.standard.set(false, forKey: "isDoneTogetherWorkout")
        
        userModel.todayCalories = 0
        userModel.todayWorkoutHours = 0
        userModel.saveUserData()
        
//        settings.isDoneTogetherWorkout = false (삭제 해야 함. UserDefaluts로 변경)
    }
}


struct MainView_Previews: PreviewProvider {
    @ObservedObject static var userModel = UserModel()
    @ObservedObject static var bunnyModel = BunnyModel()
    @ObservedObject static var workoutModel = WorkoutModel()
    
    static var previews: some View {
        MainView(userModel: userModel, bunnyModel: bunnyModel, workoutModel: workoutModel)
            .preferredColorScheme(.dark)
    }
}

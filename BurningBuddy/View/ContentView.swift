//
//  ContentView.swift
//  BurningBuddy
//
//  Created by 김동현 on 2023/05/02.
//

import SwiftUI
import CoreData

class UserSettings: ObservableObject {
    @Published var showOnboarding: Bool = true
    @Published var pageNum: Int = 0
    @Published var characterName: String = "캐릭터 이름"
    @Published var level: Int16 = 1
    @Published var nickName: String = "사람 이름"
    @Published var totalDumbbell: Int16 = 0
    @Published var goalCalories: Int16 = 0
    
    // TODO: totalWorkoutTime, todayCalories -> CoreData값으로 바꿔줘야 함
//    var totalWorkoutTime: String = ""
//    var todayCalories: Int16 = 0
    
    var isDoneTogetherWorkout: Bool = false // 둘 다 운동을 했는지 check
    var workoutData = WorkoutData() // published로 해야될 수도 있음
}

struct ContentView: View {
    @State private var showOnboarding: Bool = UserDefaults.standard.bool(forKey: "showOnboarding")
    //    @State var isWorkouting = UserDefaults.standard.bool(forKey: "isWorkouting") // 내가 운동 중인지
    //    @State var isDoneWorkout = UserDefaults.standard.bool(forKey: "isDoneWorkout") // 내가 운동 목표 달성했는지
    
    //앱이 종료될 때 현재 날짜를 기록하고, 다음에 앱이 실행될 때 해당 날짜와 비교하여 데이터를 초기화하는 방법
    private let lastLaunchDateKey = "lastLaunchDate" // 마지막으로 앱을 종료했을때의 날짜
    let formatter = DateFormatter()
    
    
    // @ObservedObject var settings = UserSettings()
    @ObservedObject var settings = UserSettings()
    
    var body: some View {
        ZStack {
            
            if !showOnboarding { // CoreData / UserDefault 값으로 판단
                switch(settings.pageNum) {
                case 0:
                    OnboardingView()
                        .environmentObject(settings)
                case 1:
                    NicknameSettingView()
                        .environmentObject(settings)
                        .background(Color(red: 30/255, green: 28/255, blue: 29/255)) // 고급진 까만것이 필요할 듯
                case 2:
                    CharacterSettingView()
                        .environmentObject(settings)
                        .background(Color(red: 30/255, green: 28/255, blue: 29/255)) // 고급진 까만것이 필요할 듯
                case 3:
                    CalorieSettingView()
                        .environmentObject(settings)
                        .background(Color(red: 30/255, green: 28/255, blue: 29/255)) // 고급진 까만것이 필요할 듯
                case 4:
                    MainView()
                        .environmentObject(settings)
                        .background(Color(red: 30/255, green: 28/255, blue: 29/255))
                default:
                    Text("온보딩 Default")
                }
            } else { // 온보딩 필요 없는 경우
                MainView()
                    .environmentObject(settings)
                    .background(Color.backgroundColor)
            }
        }.onAppear {
            if showOnboarding {
                self.settings.characterName = CoreDataManager.coreDM.readAllBunny()[0].characterName ?? "Defalut"
                
                self.settings.level = CoreDataManager.coreDM.readAllBunny()[0].level
                self.settings.nickName = CoreDataManager.coreDM.readAllUser()[0].userName ?? "Username"
                CoreDataManager.coreDM.readAllUser()[0].todayWorkoutHours = "00:00"
                CoreDataManager.coreDM.readAllUser()[0].todayCalories = 0
                //self.settings.totalWorkoutTime = CoreDataManager.coreDM.readAllUser()[0].todayWorkoutHours
                //self.settings.todayCalories = CoreDataManager.coreDM.readAllUser()[0].todayCalories
                self.settings.goalCalories = CoreDataManager.coreDM.readAllUser()[0].goalCalories
            }
            
            // userdefault의 값 초기화하기 & CoreData의 todayWorkoutHours, todayWorkoutHours 초기화
            if let lastLaunchDate = UserDefaults.standard.object(forKey: lastLaunchDateKey) as? Date {
                // 앱을 마지막으로 종료한 날짜와 오늘 켠 날짜가 같은 날이 아니라면? 데이터들을 초기화
                if !isSameDay(date1: lastLaunchDate, date2: Date()) {
                    resetData()
                }
            } else {
                resetData()
            }
            
            UserDefaults.standard.set(Date(), forKey: lastLaunchDateKey)
            
        } // onAppear
        
    }
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
        
        //settings.todayCalories = 0
        CoreDataManager.coreDM.readAllUser()[0].todayCalories = 0
        settings.isDoneTogetherWorkout = false
        //settings.totalWorkoutTime = "00:00"
        CoreDataManager.coreDM.readAllUser()[0].todayWorkoutHours = "00:00"
        
        
        print(CoreDataManager.coreDM.readAllUser()[0].todayCalories)
        print(CoreDataManager.coreDM.readAllUser()[0].todayWorkoutHours)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

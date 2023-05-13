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
    
    var totalWorkoutTime: String = ""
    var todayCalories: Int16 = 0
    var isDoneTogetherWorkout: Bool = false // 둘 다 운동을 했는지 check
    var workoutData = WorkoutData() // published로 해야될 수도 있음
}

struct ContentView: View {
    @State private var showOnboarding: Bool = UserDefaults.standard.bool(forKey: "showOnboarding")
//    @State var isWorkouting = UserDefaults.standard.bool(forKey: "isWorkouting") // 내가 운동 중인지
//    @State var isDoneWorkout = UserDefaults.standard.bool(forKey: "isDoneWorkout") // 내가 운동 목표 달성했는지
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
                self.settings.totalWorkoutTime = CoreDataManager.coreDM.readAllUser()[0].todayWorkoutHours
                self.settings.todayCalories = CoreDataManager.coreDM.readAllUser()[0].todayCalories
                self.settings.goalCalories = CoreDataManager.coreDM.readAllUser()[0].goalCalories
            }
            // 현재 시각을 출력, 현재 시각이 "00시 00분 00초"이면 userdefault의 값 초기화하기 & CoreData의 todayWorkoutHours, todayWorkoutHours 초기화
            formatter.dateFormat = "HH시 mm분 ss초"
            let result = formatter.string(from: Date())
            print(result)
            // 새로운 하루가 시작된다면 user default에 저장된 partner의 정보 초기화 & coreData의 
            if result == "00시 00분 00초" {
                UserDefaults.standard.set(false, forKey: "isWorkouting")
                UserDefaults.standard.set(false, forKey: "isDoneWorkout")
                UserDefaults.standard.set("", forKey: "partnerID")
                settings.isDoneTogetherWorkout = false
                
                if (CoreDataManager.coreDM.readAllUser()[0].todayCalories != 0)  {
                    
                }
                if (CoreDataManager.coreDM.readAllUser()[0].todayWorkoutHours != "00:00") {
                    
                }
                
            }
        } // onAppear
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

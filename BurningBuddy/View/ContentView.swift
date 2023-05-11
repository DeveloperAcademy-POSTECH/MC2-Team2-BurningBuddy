//
//  ContentView.swift
//  BurningBuddy
//
//  Created by 김동현 on 2023/05/02.
//

import SwiftUI
import CoreData

class UserSettings: ObservableObject {
    @Published var pageNum: Int = 0
    @Published var characterName: String = "웨스트"
    @Published var level: Int16 = 1
    @Published var nickName: String = "박루나"
    @Published var totalDumbbell: Int16 = 0
    @Published var totalWorkoutTime: String = ""
    @Published var todayCalories: Int16 = 0
    @Published var goalCalories: Int16 = 0
    @Published var hasPartner: Bool = false
    
    @Published var isWorkouting: Bool = false
    @Published var isDoneWorkout: Bool = false
    
    @Published var showOnboarding: Bool = true
    @Published var isDoneTogetherWorkout: Bool = false
}

struct ContentView: View {
    @State private var showOnboarding: Bool = UserDefaults.standard.bool( forKey: "showOnboarding")
    @State var isWorkouting = UserDefaults.standard.bool(forKey: "isWorkouting")
    @State var isDoneWorkout = UserDefaults.standard.bool(forKey: "isDoneWorkout")
    
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
        } // onAppear
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

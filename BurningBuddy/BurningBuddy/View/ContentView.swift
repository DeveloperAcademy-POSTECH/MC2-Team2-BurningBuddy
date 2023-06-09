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
    @Published var characterName: String = ""
    @Published var level: Int16 = 1
    @Published var nickName: String = ""
    @Published var totalDumbbell: Int16 = 0
    @Published var goalCalories: Int16 = 0
    var isDoneTogetherWorkout: Bool = false // 둘 다 운동을 했는지 check
    var workoutData = WorkoutData() // published로 해야될 수도 있음
}

struct ContentView: View {
    @State private var showOnboarding: Bool = UserDefaults.standard.bool(forKey: "showOnboarding")
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
        }
        .onAppear {
            if !showOnboarding {

                let test2 = CoreDataManager.coreDM.readAllBunny()
                let test = CoreDataManager.coreDM.readAllUser()
                if test2.isEmpty {
                    CoreDataManager.coreDM.createBunny()
                }
                if test.isEmpty  {
                    CoreDataManager.coreDM.createUser()
                }
                
                 // published로 해야될 수도 있음
                
            } else {
                settings.characterName = CoreDataManager.coreDM.readAllBunny()[0].characterName ?? "캐릭터 이름"
                settings.level = CoreDataManager.coreDM.readAllBunny()[0].level
                settings.nickName = (CoreDataManager.coreDM.readAllUser()[0].userName ?? "사람 이름")
                settings.totalDumbbell  = CoreDataManager.coreDM.readAllUser()[0].totalDumbbell
                settings.goalCalories = CoreDataManager.coreDM.readAllUser()[0].goalCalories
                settings.isDoneTogetherWorkout = false // 둘 다 운동을 했는지 check
                settings.workoutData = WorkoutData()
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(settings: UserSettings())
    }
}

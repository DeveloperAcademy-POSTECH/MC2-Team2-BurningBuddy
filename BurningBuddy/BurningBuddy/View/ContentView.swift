//
//  ContentView.swift
//  BurningBuddy
//
//  Created by 김동현 on 2023/05/02.
//

import SwiftUI
import CoreData

/**
 @ObservedObject를 활용하여 앱 전반에서 공유하는 변수들을 UserSettings라는 클래스로 관리
 가장 루트 뷰인 ContentView에서 settings라는 ObservedObject 변수로 관리하여 모든 뷰들에게 값을 넘겨준다.
 environmentObject로 넘겨줌.
 */
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
    // TODO: - showOnboarding은 @AppStorage로 관리하면 충분함.
    @State private var showOnboarding: Bool = UserDefaults.standard.bool(forKey: "showOnboarding")
    @ObservedObject var settings = UserSettings()
    
    var body: some View {
        ZStack {
            // TODO: - showOnboarding에 따라 ZStack으로 깔아주고 있음.
            /**
             초기 세팅을 해주는 구조체를 따로 만들어서, if else 문으로 나누어 처리하는 것이 필요.
             environmentObject를 세팅해줄 필요도 없음.
             싱글턴 패턴을 활용하여 DataModel을 두는 방식으로 CoreData를 활용하면 됨.
             만약 서버를 도입한다면, 데이터를 관리하는 방법을 달리 생각해볼 필요도 있음.
             */
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
            // TODO: - 전혀 필요업는 부분
            /**
             CoreData 오류로 인해 기본값을 집어 넣는 것이라고 생각됨.
             readAllBunny, readAllUser 메서드를 수정하는 것이 필요함.
             현재 onAppear modifer 안에서 메서드 로직을 구현해 놓은 것과 같음.
             CoreDataManager를 수정하고, DataModel을 하나 더 두어서 로직을 분리시키는 것이 필요.
             */
            if !showOnboarding {

                let test2 = CoreDataManager.shared.readAllBunny()
                let test = CoreDataManager.shared.readAllUser()
                if test2.isEmpty {
                    CoreDataManager.shared.createBunny()
                }
                if test.isEmpty  {
                    CoreDataManager.shared.createUser()
                }
                
                 // published로 해야될 수도 있음
                
            } else {
                settings.characterName = CoreDataManager.shared.readAllBunny()[0].characterName ?? "캐릭터 이름"
                settings.level = CoreDataManager.shared.readAllBunny()[0].level
                settings.nickName = (CoreDataManager.shared.readAllUser()[0].userName ?? "사람 이름")
                settings.totalDumbbell  = CoreDataManager.shared.readAllUser()[0].totalDumbbell
                settings.goalCalories = CoreDataManager.shared.readAllUser()[0].goalCalories
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

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
  @Published var nickName: String = "admin"
  @Published var characterName: String = "DDolDDoli"
  @Published var targetCalorie: Int = 0
  @Published var hasPartner: Bool = true
  @Published var isWorkouting: Bool = false
  @Published var isDoneWorkout: Bool = false
  @Published var showOnboarding: Bool = true
}

struct ContentView: View {
  @ObservedObject var settings = UserSettings()
  
  var body: some View {
    ZStack {
      if settings.showOnboarding {
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
          .background(Color(red: 30/255, green: 28/255, blue: 29/255))
      }
    }
    
  }
  
  
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}

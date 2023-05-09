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
    @State private var showOnboarding: Bool = UserDefaults.standard.bool( forKey: "showOnboarding")

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
          .background(Color(red: 30/255, green: 28/255, blue: 29/255))
      }
    }.onAppear {

        /**
         1. UserDefalut 또는 CoreData에 데이터가 있는지 없는지 확인 V ->
         1-1) 있다면 V
         settings를 초기화 시킨다. 기존 데이터 값으로
         1-2) 없다면 V
         settings 객체를 생성한다. (그냥 냅둔다)
         */
        
        if showOnboarding {
            self.settings.characterName = CoreDataManager.coreDM.readAllBunny()[0].characterName
            self.settings.nickName = CoreDataManager.coreDM.readAllUser()[0].
        }
        /*
         
         
         
         2. 단, 여기에서 첫 진입인지 판단하는 불리언값은 CoreData(또는 UserDefalut)처음에도 존재하여야 한다.
         임의로 true 값을 집어넣어 놓아야 한다. 그것을 첫 변수로 감지하여 첫 번째에 메인뷰로 들어갈지, 온보딩으로 들어갈 지를 정해야 한다.
         */
    }
    
  }
  
  
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
      ContentView()
  }
}

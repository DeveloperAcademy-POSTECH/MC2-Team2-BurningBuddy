//
//  ContentView.swift
//  BurningBuddy
//
//  Created by 김동현 on 2023/05/02.
//

import SwiftUI


class UserSettings: ObservableObject {
    @Published var pageNum: Int = 0
    @Published var nickName: String = "admin"
    @Published var characterName: String = "DDolDDoli"
    @Published var targetCalorie: Int = 0
    @Published var hasPartner: Bool = true
    @Published var isWorkouting: Bool = false
    @Published var isDoneWorkout: Bool = false
}

struct ContentView: View {
    @ObservedObject var settings = UserSettings()
    
    var body: some View {
        if settings.pageNum == 0 {
            NicknameSettingView()
                .environmentObject(settings)
                .background(Color(red: 30/255, green: 28/255, blue: 29/255)) // 고급진 까만것이 필요할 듯
        } else if settings.pageNum == 1 {
            CharacterSettingView()
                .environmentObject(settings)
                .background(Color(red: 30/255, green: 28/255, blue: 29/255)) // 고급진 까만것이 필요할 듯
        } else if settings.pageNum == 2 {
            CalorieSettingView()
                .environmentObject(settings)
                .background(Color(red: 30/255, green: 28/255, blue: 29/255)) // 고급진 까만것이 필요할 듯
        } else if settings.pageNum == 3 {
            MainView()
                .environmentObject(settings)
                .background(Color(red: 30/255, green: 28/255, blue: 29/255)) // 고급진 까만것이 필요할 듯
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

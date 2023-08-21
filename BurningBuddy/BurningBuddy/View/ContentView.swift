//
//  ContentView.swift
//  BurningBuddy
//
//  Created by 김동현 on 2023/05/02.
//

import SwiftUI
import CoreData

struct ContentView: View {
    // TODO: - showOnboarding은 @AppStorage로 관리하면 충분함.
    @State private var showOnboarding: Bool = UserDefaults.standard.bool(forKey: "showOnboarding")
    @AppStorage("_isFirstLaunch") var isFirst: Bool = true
    @ObservedObject var userModel = UserModel()
    @ObservedObject var bunnyModel = BunnyModel()
    @ObservedObject var workoutModel = WorkoutModel()
    
    var body: some View {
        ZStack {
            if isFirst {
                OnboardingRoot(isFirst: $isFirst, userModel: userModel, bunnyModel: bunnyModel)
            } else {
                MainView(userModel: userModel, bunnyModel: bunnyModel, workoutModel: workoutModel)
            }
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

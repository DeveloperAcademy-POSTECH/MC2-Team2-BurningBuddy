//
//  OnboardingRoot.swift
//  BurningBuddy
//
//  Created by 김동현 on 2023/08/21.
//

import SwiftUI

struct OnboardingRoot: View {
    @State var onboardingPage = 0
    @Binding var isFirst: Bool
    @ObservedObject var userModel: UserModel
    @ObservedObject var bunnyModel: BunnyModel

    var body: some View {
        VStack(spacing: 0) {
            switch onboardingPage {
            case 0:
                OnboardingSwipeView(pageNum: $onboardingPage)
            case 1:
                NicknameSettingView(userModel: userModel, pageNum: $onboardingPage)
            case 2:
                CharacterSettingView(bunnyModel: bunnyModel, pageNum: $onboardingPage)
            case 3:
                CalorieSettingView(userModel: userModel, bunnyModel: bunnyModel, pageNum: $onboardingPage, isFirst: $isFirst)
            default:
                Spacer()
            }
        }
        .onAppear {
            userModel.createUserData()
            bunnyModel.createBunnyData()
        }
    }
}

//
//  OnboardingView.swift
//  BurningBuddy
//
//  Created by 김동현 on 2023/05/06.
//

import SwiftUI

struct OnboardingView: View {
    var body: some View {
        TabView {
            OnboardingPageView(imageName: "onboarding1", title: "Welcome")
            OnboardingPageView(imageName: "onboarding2", title: "Get Started")
            OnboardingPageView(imageName: "onboarding3", title: "Explore")
        }
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
    }
}

struct OnboardingPageView: View {
    var imageName: String
    var title: String
    
    var body: some View {
        VStack {
            Text(title)
                .font(.title)
                .padding(.top, 50)
            
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding()
            
            Spacer()
        }
    }
}

struct OnboardingView_Preview: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
    
    
}

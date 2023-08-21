//
//  OnboardingView.swift
//  BurningBuddy
//
//  Created by 김동현 on 2023/05/06.
//

import SwiftUI
import UIKit

/**
 크기, 폰트, padding 등을 수정해야 함.
 VStack spacing: 0 을 기준으로 해서 컴포넌트 재배치 해야 함.
 EdgeInsets 제거 필요하며, Stack 그룹핑을 다시 해서 재정렬 해야 함.
 */
struct OnboardingView: View {
    @Binding var pageNum: Int
    
    var body: some View {
        VStack {
            TabView {
                OnboardingPageView(imageName: "Onboarding1", title: "하루 운동 목표를 설정하세요!", explain: "하루에 태울 칼로리를 선택하세요!\n나에게 맞는 난이도 설정으로\n운동강도를 조절할 수 있어요.")
                OnboardingPageView(imageName: "Onboarding2", title: "애플워치를 착용해주세요!", explain: "애플워치의 운동 기록과 연동이 되어,\n내가 소모한 칼로리와 운동시간을\n간편하게 체크해줘요!")
                OnboardingPageView(imageName: "Onboarding3", title: "함께 운동하는 즐거움을", explain: "매일 함께 운동하고 싶은 파트너와\n디바이스를 연결한 후,\n같이 운동하며 버닝해봐요!")
                OnboardingPageView(imageName: "Onboarding4", title: "목표를 달성하면 캐릭터가 성장해요!", explain: "100일 동안 핑크덤벨을 모으면\n모은 개수에 따라 버니가 성장해요!\n66개의 핑크덤벨을 모아 최종 단계의\n버니까지 성장시켜보아요!")
            }
            .tabViewStyle(PageTabViewStyle())
            .onAppear {
                setupAppearance()
            }
            Button("설명 넘어가기") {
                skipAction()
            }
            .buttonStyle(RedButtonStyle())
        }
        .padding(EdgeInsets(top: 20, leading: 30, bottom: 15, trailing: 30))
        .background(Color.backgroundColor)
        
    }
    private func setupAppearance() {
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(Color.bunnyColor)
    }
    
    private func skipAction() {
        withAnimation(.easeInOut(duration: 0.5)){
            pageNum += 1
        }
    }
}

/**
 크기, 폰트, padding 등을 수정해야 함.
 VStack spacing: 0 을 기준으로 해서 컴포넌트 재배치 해야 함.
 EdgeInsets 제거 필요하며, Stack 그룹핑을 다시 해서 재정렬 해야 함.
 */
struct OnboardingPageView: View {
    var imageName: String
    var title: String
    var explain: String
    
    var body: some View {
        VStack {
            VStack {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .scaleEffect(x: 0.8, y: 0.8)
            }
            .frame(width: UIScreen.main.bounds.width / 1.3, height: UIScreen.main.bounds.height / 2.4)
            Text(title)
                .padding(EdgeInsets(top: 50, leading: 0, bottom: 0, trailing: 0))
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.white)
                .font(.system(size: 22, weight: .bold))
            Text(explain)
                .padding(EdgeInsets(top: 19, leading: 0, bottom: 0, trailing: 0))
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(Color.subTextColor)
                .font(.system(size: 17, weight: .medium))
                .lineSpacing((17 * (1425 / 1000) - 17))
            
            Spacer()
            
        }
    }
        
}

struct OnboardingView_Preview: PreviewProvider {
    @State static var pageNum = 0
    
    static var previews: some View {
        OnboardingView(pageNum: $pageNum)
    }
}

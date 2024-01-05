//
//  OnboardingPageView.swift
//  BurningBuddy
//
//  Created by 박의서 on 1/5/24.
//

import SwiftUI

/**
 크기, 폰트, padding 등을 수정해야 함.
 VStack spacing: 0 을 기준으로 해서 컴포넌트 재배치 해야 함.
 EdgeInsets 제거 필요하며, Stack 그룹핑을 다시 해서 재정렬 해야 함.
 */
struct OnboardingPageView: View {
    var topImage: String
    var title: String
    var explain: String

    var body: some View {
        VStack {
            Image(topImage)
                .resizable()
                .scaledToFit()
                .scaleEffect(x: 0.8, y: 0.8)
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

#Preview {
    OnboardingPageView(topImage: "Onboarding1", title: "하루 운동 목표를 설정하세요!", explain: "하루에 태울 칼로리를 선택하세요!\n나에게 맞는 난이도 설정으로\n운동강도를 조절할 수 있어요.")
}

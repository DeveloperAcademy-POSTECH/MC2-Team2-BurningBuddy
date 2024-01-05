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
    @State var pageNum: Int
    @State var topImage: String = "Onboarding1"
    @State var title: String = ""
    @State var explain: String = ""

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
        .onAppear {
            self.setPage()
        }
    }
}

extension OnboardingPageView {
    func setPage() {
        switch pageNum {
        case 0:
            self.topImage = "Onboarding1"
            self.title = "하루 운동 목표를 설정하세요!"
            self.explain = "하루에 태울 칼로리를 선택하세요!\n나에게 맞는 난이도 설정으로\n운동강도를 조절할 수 있어요."
        case 1:
            self.topImage = "Onboarding2"
            self.title = "애플워치를 착용해주세요!"
            self.explain = "애플워치의 운동 기록과 연동이 되어,\n내가 소모한 칼로리와 운동시간을\n간편하게 체크해줘요!"
        case 2:
            self.topImage = "Onboarding3"
            self.title = "함께 운동하는 즐거움을"
            self.explain = "매일 함께 운동하고 싶은 파트너와\n디바이스를 연결한 후,\n같이 운동하며 버닝해봐요!"
        case 3:
            self.topImage = "Onboarding4"
            self.title = "목표를 달성하면 캐릭터가 성장해요!"
            self.explain = "100일 동안 핑크덤벨을 모으면\n모은 개수에 따라 버니가 성장해요!\n66개의 핑크덤벨을 모아 최종 단계의\n버니까지 성장시켜보아요!"
        default:
            return
        }
    }
}

struct OnboardingPageViewPreview: PreviewProvider {
    @State static var pageNum = 0

    static var previews: some View {
        OnboardingPageView(pageNum: pageNum)
    }
}

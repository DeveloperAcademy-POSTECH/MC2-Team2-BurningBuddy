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
 EdgeInsets 제거 필요하며, Stack 그룹핑을 다시 해서 재정렬 해야 함.
 */
struct OnboardingSwipeView: View {
    @Binding var pageNum: Int

    var body: some View {
        VStack(spacing: 0) {
            TabView {
                ForEach(0..<4) { number in
                    OnboardingPageView(pageNum: number)
                }
            }
            .tabViewStyle(PageTabViewStyle())
            .onAppear {
                setupAppearance()
            }
            Button("설명 넘어가기") {
                skipAction()
            }
            .buttonStyle(BurningBuddyButton(style: .red))
        }
        .padding(EdgeInsets(top: 20, leading: 30, bottom: 15, trailing: 30))
        .background(Color.backgroundColor)
    }
}

extension OnboardingSwipeView {
    private func setupAppearance() {
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(Color.bunnyColor)
    }
    private func skipAction() {
        withAnimation(.easeInOut(duration: 0.5)) {
            pageNum += 1
        }
    }
}

struct OnboardingViewPreview: PreviewProvider {
    @State static var pageNum = 0

    static var previews: some View {
        OnboardingSwipeView(pageNum: $pageNum)
    }
}

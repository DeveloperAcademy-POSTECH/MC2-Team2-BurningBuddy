//
//  LoadingAnimationView.swift
//  BurningBuddy
//
//  Created by Jay on 2023/05/11.
//

import SwiftUI


//TODO: -
/**
 SearchPartnerView와 MainView를 왔다 갔다 여러번 하면 오류가 생김.
 DispatchQueue로 일어나는 문제로 보임.
 Lottie 이미지로 대체하는 것이 성능상 더 좋을 것 같음.
 */
struct LoadingAnimationView: View {
    @State var showLoadingIndicator = [false, false, false]
    var body: some View {
        ZStack{
            if showLoadingIndicator[0]{
                GrowingCircleIndicatorView()
                    .foregroundColor(Color("iconColor"))
            }
            if showLoadingIndicator[1]{
                GrowingCircleIndicatorView()
                    .foregroundColor(Color("iconColor"))
            }
            if showLoadingIndicator[2]{
                GrowingCircleIndicatorView()
                    .foregroundColor(Color("iconColor"))
            }
        }
        .onAppear {
            for index in 0...2 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4 * Double(index)){
                    showLoadingIndicator[index].toggle()
                }
            }
        }
    }
}

struct GrowingCircleIndicatorView: View {
    
    @State private var scale: CGFloat = 0
    @State private var opacity: Double = 0
    
    var body: some View {
        let animation = Animation
            .easeIn(duration: 1.6)
            .repeatForever(autoreverses: false)
        
        return Circle()
            .scaleEffect(scale)
            .opacity(opacity)
            .onAppear {
                scale = 0.35
                opacity = 0.5
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                    withAnimation(animation) {
                        scale = 1.5
                        opacity = 0
                    }
                }
            }
    }
}

struct LoadingAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingAnimationView()
    }
}

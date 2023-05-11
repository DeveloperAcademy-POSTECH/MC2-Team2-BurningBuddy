//
//  LoadingAnimationView.swift
//  BurningBuddy
//
//  Created by Jay on 2023/05/11.
//

import SwiftUI

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
            for i in 0...2 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5 * Double(i)){
                    showLoadingIndicator[i].toggle()
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
            .easeIn(duration: 2.0)
            .repeatForever(autoreverses: false)
        
        return Circle()
            .scaleEffect(scale)
            .opacity(opacity)
            .onAppear {
                scale = 0.25
                opacity = 1
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                    withAnimation(animation) {
                        scale = 1.2
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

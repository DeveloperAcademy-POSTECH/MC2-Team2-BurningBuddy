//
//  ButtonComponent.swift
//  BurningBuddy
//
//  Created by 김동현 on 2023/05/06.
//

import SwiftUI

struct RedButtonStyle: ButtonStyle {
    @State var fontSize: CGFloat = 17
    @State private var pressed = false
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: fontSize, weight: .bold))
            .foregroundColor(.white)
            .padding()
            .frame(minWidth: 0, maxWidth: .infinity)
            .foregroundColor(.white)
            .background(RoundedRectangle(cornerRadius: 15.0).fill(Color(red: 255 / 255, green: 0 / 255, blue: 82 / 255))
            )
    }
}

struct GrayButtonStyle: ButtonStyle {
    @State var fontSize: CGFloat = 17
    @State private var pressed = false
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: fontSize, weight: .bold))
            .foregroundColor(Color(red: 28 / 255, green: 28 / 255, blue: 30 / 255))
            .padding()
            .frame(minWidth: 0, maxWidth: .infinity)
            .foregroundColor(.white)
            .background(RoundedRectangle(cornerRadius: 15.0).fill(Color(red: 199 / 255, green: 199 / 255, blue: 204 / 255))
            )
    }
}

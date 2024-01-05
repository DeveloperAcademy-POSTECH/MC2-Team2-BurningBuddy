//
//  ButtonComponent.swift
//  BurningBuddy
//
//  Created by 김동현 on 2023/05/06.
//

import SwiftUI

/**
 컬러, 폰트 등의 수정이 필요. 일부 코드만 수정하면 컴포넌트로 활용할 수 있음.
 */
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
            .background(RoundedRectangle(cornerRadius: 12.0).fill(Color.bunnyColor)
                
            )
    }
}

struct RedButtonStyle2: ButtonStyle {
    @State var fontSize: CGFloat = 17
    @Binding var isModeSelected: Bool

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: fontSize, weight: .bold))
            .foregroundColor(isModeSelected ? .white : .white.opacity(0.3))
            .padding()
            .frame(minWidth: 0, maxWidth: .infinity)
            .background(RoundedRectangle(cornerRadius: 12.0).fill(isModeSelected ? Color.bunnyColor : Color.bunnyColor.opacity(0.3)))
        
    }
}


struct GrayButtonStyle: ButtonStyle {
    @State var fontSize: CGFloat = 17
    @State private var pressed = false
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: fontSize, weight: .bold))
            .padding()
            .frame(minWidth: 0, maxWidth: .infinity)
            .foregroundColor(.backgroundColor)
            .background(RoundedRectangle(cornerRadius: 12.0).fill(Color.subGray)
            )
    }
}

struct XbuttonStyle: ButtonStyle {
    @State private var pressed = false
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            Image("Close")
        
    }
}

struct TwoRedButtonStyle: ButtonStyle {
    @State var fontSize: CGFloat = 17
    @State private var pressed = false
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: fontSize, weight: .bold))
            .foregroundColor(.white)
            .padding()
            .frame(minWidth: 0, maxWidth: .infinity)
            .foregroundColor(.white)
            .background(RoundedRectangle(cornerRadius: 8.0).fill(Color.bunnyColor)
                
            )
    }
}

struct TwoGrayButtonStyle: ButtonStyle {
    @State var fontSize: CGFloat = 17
    @State private var pressed = false
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: fontSize, weight: .bold))
            .padding()
            .frame(minWidth: 0, maxWidth: .infinity)
            .foregroundColor(.backgroundColor)
            .background(RoundedRectangle(cornerRadius: 8.0).fill(Color.subGray)
            )
    }
}

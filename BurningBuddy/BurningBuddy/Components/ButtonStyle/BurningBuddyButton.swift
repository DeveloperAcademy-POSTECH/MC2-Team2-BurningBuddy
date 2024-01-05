//
//  ButtonComponent.swift
//  BurningBuddy
//
//  Created by 김동현 on 2023/05/06.
//

import SwiftUI

enum BurningBuddyButtonStyle {
    case red
    case redOpacity
    case redShort
    case grey
    case greyShort
}

struct BurningBuddyButton: ButtonStyle {
    @State var fontSize: CGFloat = 18
    @State var fontColor: Color = .white
    @State var cornerRadius: CGFloat = 12.0
    @State var color: Color = Color.bunnyColor
    var style: BurningBuddyButtonStyle

    init(style: BurningBuddyButtonStyle = .red) {
        self.style = style
        setStyle()
    }

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: fontSize, weight: .bold))
            .foregroundColor(fontColor)
            .padding()
            .frame(minWidth: 0, maxWidth: .infinity)
            .background(RoundedRectangle(cornerRadius: cornerRadius).fill(color))
    }

    func setStyle() {
        switch self.style {
        case .red:
            return
        case .redOpacity:
            fontColor = .white.opacity(0.3)
        case .redShort:
            cornerRadius = 8.0
        case .grey:
            fontColor = .backgroundColor
            color = Color.subGray
        case .greyShort:
            fontColor = .backgroundColor
            cornerRadius = 8.0
            color = Color.subGray
        }
    }
}

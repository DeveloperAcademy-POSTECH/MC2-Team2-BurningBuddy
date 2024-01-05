//
//  XButtonStyle.swift
//  BurningBuddy
//
//  Created by 박의서 on 1/5/24.
//

import SwiftUI

struct XButtonStyle: ButtonStyle {
    @State private var pressed = false

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            Image("Close")
    }
}

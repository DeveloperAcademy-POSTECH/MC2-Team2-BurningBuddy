//
//  ContentView.swift
//  BurningBuddy
//
//  Created by 김동현 on 2023/05/02.
//

import SwiftUI

struct ContentView: View {
    @State private var nickname: String = String()
    @State var isMember: Bool = false
    
    var body: some View {
        
        ZStack {
            if isMember {
                MainView()
            } else {
//                NicknameSettingView(isMember: $isMember)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

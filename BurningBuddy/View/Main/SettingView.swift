//
//  SettingView.swift
//  BurningBuddy
//
//  Created by 김동현 on 2023/05/02.
//

import Foundation
import SwiftUI

struct SettingView: View {
    var body: some View {
        ZStack{
            Text("내 정보")
                .font(.system(size: 17, weight: .bold, design: .default))
                .padding(.bottom, 800)
            Rectangle()
                .frame(width: 344.5, height: 74.54)
                .foregroundColor(Color(red: 2.0, green: 2.0, blue: 5.0))
                .cornerRadius(20)
        }
    }
}


struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}

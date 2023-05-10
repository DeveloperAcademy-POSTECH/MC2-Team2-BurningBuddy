//
//  SettingView.swift
//  BurningBuddy
//
//  Created by 김동현 on 2023/05/02.
//

import Foundation
import SwiftUI
/**
 settings에 있는 변수들의 값들을 그냥 보여주면 된다.
 단, update 할 수 있는 변수가,,, 칼로리가 있기 때문에, 그것만 업데이트 시키는 코드를 만들어서 넣어주어야 한다.
 */
struct SettingView: View {
    var body: some View {
        ZStack{
            VStack{
                Text("내 정보")
                    .offset(y: 10)
               Rectangle()
                    .frame(height: 74)
                    .padding(EdgeInsets(top: 63, leading: 15, bottom: 0, trailing: 15))
            }
        }
     
        
    }
}


struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}

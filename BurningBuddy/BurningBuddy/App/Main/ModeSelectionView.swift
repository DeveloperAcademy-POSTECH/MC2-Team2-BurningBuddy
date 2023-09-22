//
//  ModeSelectionView.swift
//  BurningBuddy
//
//  Created by Bokyung on 2023/09/22.
//

import SwiftUI

// 유저가 1인 플레이를 할지, 2인 플레이를 할지 선택하는 뷰입니다. 
struct ModeSelectionView: View {
    var body: some View {
        VStack (spacing: 0){
            HStack (spacing: 0){
                Text("원하는 모드를 \n선택해주세요")
                    .font(.system(size: 28, weight: .bold))
                Spacer()
                Image(systemName: "info.circle")
            } // HStack
            Spacer()
            
            Button("운동시작하기", action: {
                // action
            })
            .buttonStyle(TwoRedButtonStyle())
            
        } // VStack
        .padding(.bottom, 48)
        .padding(.horizontal, 24)
        
        
    }
}

#Preview {
    ModeSelectionView()
}

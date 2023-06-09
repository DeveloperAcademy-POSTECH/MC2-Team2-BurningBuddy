//
//  NotFoundPartnerView.swift
//  BurningBuddy
//
//  Created by 김동현 on 2023/05/07.
//

import Foundation
import SwiftUI
/**
 다시 찾을래요를 클릭했을 때, SearchPartnerView에서 다시 통신 연결을 해주는 로직이 실행되어야 한다.
 */
struct NotFoundPartnerView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            // 모달 뷰의 제목
            ZStack {
                Text("발견된 파트너가 없어요!")
                    .font(.system(size: 17, weight: .semibold))
            }
            Spacer()
            // 모달 뷰의 이미지
            Image(systemName: "person.crop.circle.fill")
                .resizable()
                .frame(width: 93, height: 91)
                .foregroundColor(Color.bunnyColor)
            Spacer()
            
            // 모달 뷰의 텍스트
            Text("더 가까이 와서 연결해보세요")
                .multilineTextAlignment(.center)
                .font(.system(size: 17, weight: .medium))
            Spacer()
            // 모달 뷰의 버튼
            Button(action: {
                // 버튼을 눌렀을 때 수행할 액션
                presentationMode.wrappedValue.dismiss()
                
            }, label: {
                Text("다시 찾을래요")
            })
            .buttonStyle(RedButtonStyle())
        }
        .padding(EdgeInsets(top: 20, leading: 30, bottom: 15, trailing: 30))
        
        
    }
}


struct NotFoundPartnerView_Previews: PreviewProvider {
    static var previews: some View {
        NotFoundPartnerView()
    }
}

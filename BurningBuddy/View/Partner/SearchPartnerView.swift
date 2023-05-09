//
//  SearchPartnerView.swift
//  BurningBuddy
//
//  Created by 김동현 on 2023/05/02.
//

import Foundation
import SwiftUI
/**
 화면 분할하여 파일 재생성 하기..
 통신에 많은 시간을 써야 할 것 같다....
 연결하기를 누를 때, 파트너의 이름을 저장하는 것이 필요하다.
 토큰이 계속 남아있을 수 있는가?의 문제도 있다. 다시 연결되어 데이터를 전송할 때, 문제가 되지 않을까? 하는 궁금함이 있다.
 */
struct SearchPartnerView: View {
    @EnvironmentObject var settings: UserSettings
    @State var isSearchedPartner: Bool = false // 화면 전환용
    @State var notFoundPartner: Bool = false // 모달용
    @State var partnerData: String = "상대방 닉네임" // TODO: - 데이터 타입 지정 필요

    @StateObject var niObject = NISessionManager()
    @State var isLaunched = true
    @State var isLocalNetworkPermissionDenied = false
    let localNetAuth = LocalNetworkAuthorization() // MPC를 위한 객체생성
    
    var body: some View {
        
        VStack {
            switch(niObject.isBumped) {
            case false:
                // 파트너를 찾을때 NI를 가져오면 됩니당 ~!!
                Text("내 파트너를 \n찾는 중이에요")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.white)
                    .font(.system(size: 30, weight: .bold, design: .default))
                switch(niObject.findingPartnerState) {
                case .ready:
                    Text("ready")
                        .foregroundColor(.white)
                case .finding:
                    Text("finding")
                        .foregroundColor(.white)
                case .found:
                    Text("found")
                        .foregroundColor(.white)
                }
                Text("서로의 휴대폰을 가까이 붙여주세요")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.white)
                    .padding(EdgeInsets(top: 1, leading: 0, bottom: 90, trailing: 0))
                
            case true:
                Text("내 주변 파트너를 \n발견했어요")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.white)
                    .font(.system(size: 30, weight: .bold, design: .default))
                Text("연결할 파트너가 맞나요?")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.white)
                    .padding(EdgeInsets(top: 1, leading: 0, bottom: 90, trailing: 0))
            }
            ZStack {
                Circle()
                    .foregroundColor(Color(red: 44/255, green: 44/255, blue: 46/255))
                    .padding(EdgeInsets(top: -70, leading: -70, bottom: -70, trailing: -70))
                Circle()
                    .foregroundColor(Color(red: 74/255, green: 74/255, blue: 77/255))
                    .padding(EdgeInsets(top: -8, leading: -8, bottom: -8, trailing: -8))
                Circle()
                    .foregroundColor(Color(red: 124/255, green: 124/255, blue:129/255, opacity: 0.8))
                    .padding(EdgeInsets(top: 54, leading: 54, bottom: 54, trailing: 54))
                VStack {
                    switch(niObject.isBumped) {
                    case true:
                        Image("Image")
                        Text(partnerData)
                    case false:
                        Text("이미지가 들어갈 것이다.")
                        Text("검색중...")
                    }
                }
                .padding(EdgeInsets(top: 106, leading: 106, bottom: 106, trailing: 106))
            }
            Spacer()
            Button("안녕") {
                switch niObject.findingPartnerState {
                case .ready:
                    niObject.start()
                    niObject.findingPartnerState = .finding
                    if isLaunched {
                        localNetAuth.requestAuthorization { auth in
                            isLocalNetworkPermissionDenied = !auth
                        }
                        isLaunched = false
                    }
                case .finding:
                  
                    niObject.stop()
                    niObject.findingPartnerState = .ready
                case .found:
                    niObject.stop()
                    niObject.findingPartnerState = .ready
                }
            }
            switch(niObject.isBumped) {
            case true:
                HStack {
                    Button("다시 연결할래요", action: {
                        
                    })
                    .buttonStyle(GrayButtonStyle())
                    
                    Button("연결하기", action: {
                        
                    })
                    .buttonStyle(RedButtonStyle())
                }
            case false:
                Text("")
            }
        }
        .padding(EdgeInsets(top: 20, leading: 25, bottom: 10, trailing: 25))
        .background(Color(red: 30/255, green: 28/255, blue: 29/255))
        .sheet(isPresented: self.$notFoundPartner) {
            if #available(iOS 16.0, *) {
                NotFoundPartnerView()
                    .presentationDetents([.fraction(0.4)])
                    .background(Color(red: 30/255, green: 28/255, blue: 29/255))
            } else {
                // Fallback on earlier versions
                NotFoundPartnerView()
                    .background(Color(red: 30/255, green: 28/255, blue: 29/255))
            }
        }
        .onAppear {
            
        }
    } // body End
    
}




struct SearchPartnerView_Previews: PreviewProvider {
    static var previews: some View {
        SearchPartnerView()
    }
}

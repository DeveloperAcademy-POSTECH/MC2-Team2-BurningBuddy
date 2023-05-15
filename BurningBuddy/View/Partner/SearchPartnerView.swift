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
    @Environment(\.presentationMode) var presentationMode
    @State var isSearchedPartner: Bool = false // 화면 전환용
    @State var notFoundPartner: Bool = false // 모달용
    @State var partnerData: String = "상대방 닉네임" // TODO: - 데이터 타입 지정 필요
    
    @State private var beforeStart: Bool = false
    @StateObject private var niObject = NISessionManager()
    @State private var isLaunched = true
    @State var isLocalNetworkPermissionDenied = false
    @State private var startWorkout: Bool = false
    @State private var tag:Int? = nil
    @State var isNextButtonTapped = false
    @Binding var mainViewNavLinkActive: Bool
    
    private let localNetAuth = LocalNetworkAuthorization() // MPC를 위한 객체생성
    
    var body: some View {
        
        VStack {
            switch(niObject.isBumped) {
            case false:
                Text("내 파트너를 \n찾는 중이에요")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(Color.mainTextColor)
                    .font(.system(size: 28, weight: .bold, design: .default))
                Text("서로의 휴대폰을 가까이 붙여주세요")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(Color.mainTextColor)
                    .padding(EdgeInsets(top: 1, leading: 0, bottom: 90, trailing: 0))
                
            case true:
                Text("내 주변 파트너를 \n발견했어요")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(Color.mainTextColor)
                    .font(.system(size: 28, weight: .bold))
                Text("연결할 파트너가 맞나요?")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(Color.mainTextColor)
                    .padding(EdgeInsets(top: 1, leading: 0, bottom: 0, trailing: 0))
            }
            
            
            switch(niObject.isBumped) {
            case true:
                ZStack{
                    Image("circleImage")
                    VStack(spacing: 0) {
                        Image("person-fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 88)
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(Color.bunnyColorSub, Color.bunnyColor)
                    }
                  Text(niObject.bumpedName)
                      .font(.system(size: 17, weight: .semibold))
                      .padding(EdgeInsets(top: 120, leading: 0, bottom: 0, trailing: 0))
                }
                
            case false:
                LoadingAnimationView()
            }
            Spacer()
            switch(niObject.isBumped) {
            case true:
                HStack(spacing: 13) {
                    Button("다시 연결할래요", action: {
                        niObject.isBumped = false
                        niObject.findingPartnerState = .finding
                    })
                    .buttonStyle(TwoGrayButtonStyle())
                    NavigationLink(isActive: $isNextButtonTapped, destination: {
                        WorkoutView(mainViewNavLinkActive: $mainViewNavLinkActive)
                    }, label: {
                        Button("운동 시작하기") {
                            self.beforeStart = true
                            UserDefaults.standard.set(true, forKey: "isWorkouting")
                            UserDefaults.standard.set(niObject.bumpedID?.uuidString, forKey: "partnerID") // 파트너의 UUID값을 user default에 저장
                            print("Navi link 안")
                        }.buttonStyle(TwoRedButtonStyle())
                    })
                }
            case false:
                Text("")
            }
        }
        .onAppear{
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
        .padding(EdgeInsets(top: 20, leading: 30, bottom: 15, trailing: 25))
        .background(Color.backgroundColor)
        .sheet(isPresented: self.$notFoundPartner) {
            if #available(iOS 16.0, *) {
                NotFoundPartnerView()
                    .presentationDetents([.fraction(0.4)])
                    .background(Color.backgroundColor)
            }
        }
        .alert(isPresented:$beforeStart) {
            Alert(
                title: Text("애플워치를 착용하고 있나요?"),
                message: Text("애플워치를 착용한 후 피트니스 앱의 운동 시작하기를 눌러주세요. 운동량 측정을 통해 캐릭터를 성장시킬 수 있습니다."),
                primaryButton: .destructive(Text("뒤로가기")) {
                    print("tap cancel")
                },
                secondaryButton: .cancel(Text("착용했어요")) {
                    UserDefaults.standard.set(true, forKey: "isWorkouting") // 사용자가 운동 중인지 userdefault에 저장
                    self.beforeStart = false
                    self.isNextButtonTapped = true
                    settings.workoutData.setWorkoutStartTime()
                }
            )
        }
        .navigationBarTitle("")
    } // end body
    
}



struct SearchPartnerView_Previews: PreviewProvider {
    @State static var value: Bool = true
    static var previews: some View {
        SearchPartnerView(mainViewNavLinkActive: $value)
            .environmentObject(UserSettings())
    }
}

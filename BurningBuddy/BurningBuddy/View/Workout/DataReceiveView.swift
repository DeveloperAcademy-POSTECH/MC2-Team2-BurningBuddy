//
//  DataReceiveView.swift
//  BurningBuddy
//
//  Created by Bokyung on 2023/05/13.
//

import SwiftUI

struct DataReceiveView: View {
    @State var isSearchedPartner: Bool = false // 화면 전환용
    @State var notFoundPartner: Bool = false // 모달용
    
    @State private var beforeStart: Bool = false
    @StateObject var niObject: NISessionManager
    @State private var isLaunched = true
    @State var isLocalNetworkPermissionDenied = false
    @State private var startWorkout: Bool = false
    @State private var tag:Int? = nil
    @State var isNextButtonTapped = false
    @Binding var isDataReceived: Bool
    @Binding var checkPartner: Bool
    
    private let localNetAuth = LocalNetworkAuthorization() // MPC를 위한 객체생성
    
    var body: some View {
        VStack {
            Text("내 파트너의 데이터를\n가져오는 중이에요!")
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(Color.mainTextColor)
                .font(.system(size: 28, weight: .bold, design: .default))
            switch(niObject.findingPartnerState) {
            case .ready:
                Text("ready")
                    .foregroundColor(Color.mainTextColor)
            case .finding:
                Text("finding")
                    .foregroundColor(Color.mainTextColor)
            case .found:
                Text("found")
                    .foregroundColor(Color.mainTextColor)
            }
            Text("서로의 휴대폰을 가까이 붙여주세요")
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(Color.mainTextColor)
                .padding(EdgeInsets(top: 1, leading: 0, bottom: 90, trailing: 0))
            Spacer()
            
            LoadingAnimationView()
            
            Spacer()
        }
        .onAppear{
            print("DataReceiveView OnAppear 내부")
            self.startNI()
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
        .navigationBarTitle("")
    } // end body
    
    private func startNI() {
        print("findingPartnerState : \(niObject.findingPartnerState)")
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
            
            //print("상대방 ID : \(settings.partnerID!)")
            niObject.findingPartnerState = .ready
        case .found:
            if niObject.isBumped { // 통신이 됐다.
                // TODO: -5월 14일: 웨스트 여기서부터 해보자~
            }
            // 상대방이 맞으면
            if niObject.bumpedID?.uuidString == UserDefaults.standard.string(forKey: "partnerID") {
                // ==================================================
                // 나와 상대방 모두가 목표량을 달성했는지를 확인하는 부분
                print("나와 상대방 모두 목표량을 달성했는지 확인하기")
                print("niObject.bumpedIsDoneTargetCalories: \(niObject.bumpedIsDoneTargetCalories)")
                print("UserDefaults.standard.bool(forKey: isDoneWorkout): \(UserDefaults.standard.bool(forKey: "isDoneWorkout"))")
                // ==================================================
                if niObject.bumpedIsDoneTargetCalories && UserDefaults.standard.bool(forKey: "isDoneWorkout") {
                    self.settings.isDoneTogetherWorkout = true
                } else {
                    self.settings.isDoneTogetherWorkout = false
                }
                
            } else { // 상대방이 아니면
                niObject.findingPartnerState = .finding
                print("상대방을 찾지 못함")
            }
            niObject.stop()
            niObject.findingPartnerState = .ready
            // niObject.isBumped true일 때
            // 모달이 내려가기 위한 부분 -> 이 부분이 실행되고.
            self.isDataReceived = true
            self.checkPartner = false
        }
    }
    
    
}
//struct DataReceiveView_Previews: PreviewProvider {
//    @State static var value: Bool = true
//    static var previews: some View {
//        DataReceiveView(mainViewNavLinkActive: $value, isDataReceived: <#Binding<Bool>#>)
//            .environmentObject(UserSettings())
//    }
//}


//
//  DataReceiveView.swift
//  BurningBuddy
//
//  Created by Bokyung on 2023/05/13.
//

import SwiftUI

struct DataReceiveView: View {
    @EnvironmentObject var settings: UserSettings
    @State var isSearchedPartner: Bool = false // 화면 전환용
    @State var notFoundPartner: Bool = false // 모달용
    
    @State private var beforeStart: Bool = false
    @StateObject private var niObject = NISessionManager()
    @State private var isLaunched = true
    @State var isLocalNetworkPermissionDenied = false
    @State private var startWorkout: Bool = false
    @State private var tag:Int? = nil
    @State var isNextButtonTapped = false
    @Binding var isDataReceived: Bool
    
    private let localNetAuth = LocalNetworkAuthorization() // MPC를 위한 객체생성
    
    var body: some View {
        VStack {
            Text("내 파트너의 데이터를 \n가져오는 중이에요")
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
                if niObject.bumpedID?.uuidString == UserDefaults.standard.string(forKey: "partnerID") {
                    // 나와 상대방 모두가 목표량을 달성했는지를 확인하는 부분
                    if !niObject.bumpedIsDoneTargetCalories || UserDefaults.standard.bool(forKey: "isDoneWorkout") {
                        self.settings.isDoneTogetherWorkout = false
                    } else {
                        self.settings.isDoneTogetherWorkout = true
                    }
                    self.isNextButtonTapped = true

                    print("상대방 ID : \(UserDefaults.standard.string(forKey: "partnerID") ?? "no partnerID")")
                    print("StartNI 내부 메서드 isDoneTogetherWorkout 값 : \(self.settings.isDoneTogetherWorkout)")
                    
                } else { // 상대방이 아니면
                    niObject.findingPartnerState = .finding
                    print("상대방을 찾지 못함")
                }
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
        .navigationBarTitle("")
    } // end body
    
    private func startNI() {
        
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
            // 상대방이 맞으면
            if niObject.bumpedID?.uuidString == UserDefaults.standard.string(forKey: "partnerID") {
                // 나와 상대방 모두가 목표량을 달성했는지를 확인하는 부분
                if !niObject.bumpedIsDoneTargetCalories || UserDefaults.standard.bool(forKey: "isDoneWorkout") {
                    self.settings.isDoneTogetherWorkout = false
                } else {
                    self.settings.isDoneTogetherWorkout = true
                }
                self.isSuccessNext = true

                print("상대방 ID : \(UserDefaults.standard.string(forKey: "partnerID") ?? "no partnerID")")
                print("StartNI 내부 메서드 isDoneTogetherWorkout 값 : \(self.settings.isDoneTogetherWorkout)")
                
            } else { // 상대방이 아니면
                niObject.findingPartnerState = .finding
                print("상대방을 찾지 못함")
            }
            niObject.stop()
            niObject.findingPartnerState = .ready
        }
}



struct DataReceiveView_Previews: PreviewProvider {
    @State static var value: Bool = true
    static var previews: some View {
        DataReceiveView(mainViewNavLinkActive: $value)
            .environmentObject(UserSettings())
    }
}


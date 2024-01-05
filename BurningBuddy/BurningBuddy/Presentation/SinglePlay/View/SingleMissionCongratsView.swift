//
//  SingleMissionCongratsView.swift
//  BurningBuddy
//
//  Created by Bokyung on 2023/09/30.
//

import SwiftUI

struct SingleMissionCongratsView: View {
    @ObservedObject var userModel: UserModel
    @ObservedObject var bunnyModel: BunnyModel
    @ObservedObject var workoutModel: WorkoutModel
    
    @State var title: String
    @State var article: String
    @State var imageName: String
    @State var buttonName: String
    @State var imageTiltValue: Int
    @Binding var mainViewNavLinkActive: Bool
    @State var levelupViewPresent: Bool = false
    /**
     운동을 성공적으로 종료한 것을 감지하는 변수 필요
     */
    var body: some View {
        VStack {
            Text(title)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(Color.mainTextColor)
                .font(.system(size: 28, weight: .bold, design: .default))
            
            Text(article)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
                .font(.system(size: 17, weight: .regular, design: .default))
                .lineSpacing(TextUtil().calculateLineSpacing(17, 143.5))
            
            Spacer()
            Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 182, height: 137)
                .padding(EdgeInsets(top: 30, leading: 30, bottom: 30, trailing: 30))
                .foregroundColor(Color.bunnyColor)
                .rotationEffect(Angle(degrees: Double(imageTiltValue)))
            
            
            Spacer()
            Button(buttonName, action: {
                /* 테스트용 */
                let templevel = bunnyModel.bunnyLevel
                
                // 덤벨 획득, 레벨 업 체크
                if UserDefaults.standard.bool(forKey: "isDoneTogetherWorkout") {
                    userModel.totalDumbbell += 1
                    if bunnyModel.bunnyLevel < 7 {
                        bunnyModel.bunnyLevel += checkLevelUp(presentLevel: Int16(userModel.totalDumbbell)) ? 1 : 0
                    }
                    userModel.saveUserData()
                    bunnyModel.saveBunnyData()
                }
                if templevel != bunnyModel.bunnyLevel {
                    self.levelupViewPresent = true
                }
                mainViewNavLinkActive = false
                UserDefaults.standard.set("", forKey: "partnerID")
            })
            .buttonStyle(BurningBuddyButton(style: .red))
        }
        .sheet(isPresented: self.$levelupViewPresent) {
            LevelUpView(userModel: userModel, bunnyModel: bunnyModel)
                .background(Color(red: 30/255, green: 28/255, blue: 29/255))
        }
        .padding(EdgeInsets(top: 50, leading: 30, bottom: 15, trailing: 30)) // 전체 아웃라인
        .background(Color.backgroundColor)
        .navigationBarHidden(true)
        
    }
    
    private func checkLevelUp(presentLevel: Int16) -> Bool {
        switch presentLevel {
        case 3:
            return true
        case 7:
            return true
        case 21:
            return true
        case 30:
            return true
        case 45:
            return true
        case 66:
            return true
        default:
            return false
        }
    }
}


#Preview {
    SingleMissionCongratsView(userModel: UserModel(), bunnyModel: BunnyModel(), workoutModel: WorkoutModel(), title: "축하해요!🎉\n목표달성에 성공했어요!", article: "목표 달성에 성공해, \n핑크덤벨 하나를 선물로 드려요!", imageName: "dumbbell.fill", buttonName: "메인으로 가기", imageTiltValue: -46, mainViewNavLinkActive: .constant(true))
}

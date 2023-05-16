//
//  MissionCongratsView.swift
//  BurningBuddy
//
//  Created by 김동현 on 2023/05/07.
//

import Foundation
import SwiftUI
/**
 특별한 로직은 필요 없을 것 같다.
 왜냐하면, 특정한 조건에 나오는 뷰이기 때문이다.
 실패한 캐릭터만 보여주면 족하다. 메인으로 가는 이동 액션만 잘 넣어주면 되겠다.
 */
struct MissionCongratsComponent: View {
    @EnvironmentObject var settings: UserSettings
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
                let templevel = settings.level
                
                if settings.isDoneTogetherWorkout {
                    settings.totalDumbbell += 1
                    CoreDataManager.coreDM.readAllUser()[0].totalDumbbell += 1
                    settings.level += checkLevelUp(presentLevel: settings.totalDumbbell) ? 1 : 0
                    CoreDataManager.coreDM.readAllBunny()[0].level += checkLevelUp(presentLevel: settings.totalDumbbell) ? 1 : 0
                    CoreDataManager.coreDM.update()
                }
                if templevel != settings.level {
                    self.levelupViewPresent = true
                }
                mainViewNavLinkActive = false
                UserDefaults.standard.set("", forKey: "partnerID")
            })
            .buttonStyle(RedButtonStyle())
        }
        .sheet(isPresented: self.$levelupViewPresent) {
            LevelUpView()
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


//struct MissionCongratsView_Previews: PreviewProvider {
//
//    static var previews: some View {
//        MissionCongratsComponent(title: "축하해요!🎉\n목표달성에 성공했어요!", article: "나의 파트너가 모두 목표 달성에\n성공해, 핑크덤벨 하나를 선물로 드려요!", imageName: "dumbbell.fill", buttonName: "메인으로 가기", imageTiltValue: -45, mainViewNavLinkActive: $mainViewNavLinkActive)
//    }
//}


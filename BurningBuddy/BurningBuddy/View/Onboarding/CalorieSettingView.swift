//
//  CalorieSettingView.swift
//  BurningBuddy
//
//  Created by 김동현 on 2023/05/06.
//
import SwiftUI
/**
 초기 값 설정시 여기에서 한 번 CoreData(or UserDefalut)에 저장해야 한다.
 */
struct CalorieSettingView: View {
    @EnvironmentObject var settings: UserSettings
    @State private var firstSliderDrag: Bool = false
    @State private var sliderMessage: String = "목표 칼로리를 설정해주세요!"
    @State private var userLevel = "초급자"
    @State var sliderValue: Double = 200
    @State var isTopButtonHidden: Bool = false
    
    var body: some View {
        
        VStack {
            if !isTopButtonHidden {
                Button(action: {
                    settings.pageNum -= 1
                }, label: {
                    Image(systemName: "chevron.left")
                        .resizable()
                        .frame(width: 10, height: 19)
                })
                .foregroundColor(Color.mainTextColor)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
            }
            Text("목표 칼로리를 \n설정해주세요")
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(Color.mainTextColor)
                .font(.system(size: 28, weight: .bold))
            Text(settings.pageNum == 4 ? "본인의 운동 수행 능력에 맞게\n조절해주세요!" : "운동 목표량을 설정해주세요\n나중에도 변경가능해요")
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(Color.subTextColor)
                .padding(EdgeInsets(top: 1, leading: 0, bottom: 90, trailing: 0))
                .lineSpacing(TextUtil().calculateLineSpacing(17, 143.5))
            Spacer()
            Spacer()
            VStack {
                Text(sliderValue >= 150 && sliderValue <= 300 ? "초급자" : sliderValue > 300 && sliderValue <= 500 ? "중급자" : "상급자")
                    .font(.system(size: 24, weight: .bold))
                
                Slider(value: $sliderValue, in: 150...800, step: 1)
                    .padding()
                    .tint(Color.bunnyColor)
                
                Text("\(sliderValue, specifier: "%.0f")Kcal")
                    .font(.system(size: 28, weight: .bold))
                Spacer()
                
                Text(sliderValue >= 150 && sliderValue <= 300 ? "부담없이 운동하고 싶어요" : sliderValue > 300 && sliderValue <= 500 ? "어느 정도는 움직이고 싶어요" : "빡세게 운동해볼래요")
                    .font(.system(size: 17, weight: .medium))
                    .foregroundColor(Color.subTextColor)
                Spacer()
            }
            
            Spacer()
            Button("확인", action: {
                saveCalorie()
                toggleShowOnboarding()
            })
            .buttonStyle(RedButtonStyle())
        }
        .padding(EdgeInsets(top: 10, leading: 30, bottom: 15, trailing: 30))
        .background(Color.backgroundColor)
    }
    
    private func saveCalorie() {
        // 유저 정보 Core데이터에 생성
        if settings.pageNum != 4 { // SettingView에서 재사용하기 위해
            settings.pageNum += 1
        }
        settings.goalCalories = Int16(sliderValue)
        
        CoreDataManager.coreDM.readAllUser()[0].goalCalories = Int16(self.sliderValue)
        CoreDataManager.coreDM.update()
        toggleShowOnboarding()
    }
    
    private func toggleShowOnboarding() {
        UserDefaults.standard.set(true, forKey: "showOnboarding")
    }
}

struct TextUtil {
    func calculateLineSpacing(_ fontsize: Int, _ percent: Double) -> CGFloat {
        return CGFloat(Double(fontsize) * (percent / Double(100)) - Double(fontsize))
    }
}



struct CalorieSettingView_Previews: PreviewProvider {
    @State var isMember: Bool = true
    
    static var previews: some View {
        CalorieSettingView()
            .environmentObject(UserSettings())
    }
}



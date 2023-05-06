//
//  CalorieSettingView.swift
//  BurningBuddy
//
//  Created by 김동현 on 2023/05/06.
//
import SwiftUI

struct CalorieSettingView: View {
    @EnvironmentObject var settings: UserSettings
    @State private var firstSliderDrag: Bool = false
    @State private var sliderValue: Double = 200
    @State private var sliderMessage: String = "목표 칼로리를 설정해주세요!"
    @State private var userLevel = "초급자"
    
    var body: some View {
        VStack {
            Text("목표 칼로리를 \n설정해주세요")
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.white)
                .font(.system(size: 30, weight: .bold))
            Text(settings.pageNum == 4 ? "본인의 운동 수행 능력에 맞게\n 조절해주세요!" : "운동 목표량을 설정해주세요\n나중에도 변경가능해요")
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.white)
                .padding(EdgeInsets(top: 1, leading: 0, bottom: 90, trailing: 0))
                .lineSpacing(TextUtil().calculateLineSpacing(17, 143.5))
                
            Spacer()

            Spacer()
            VStack {
                
                Text(sliderValue >= 150 && sliderValue <= 300 ? "초급자" : sliderValue > 300 && sliderValue <= 500 ? "중급자" : "상급자")
                    .font(.system(size: 24, weight: .bold))
                
                Slider(value: $sliderValue, in: 150...800, step: 1)
                .padding()
                .tint(Color(red: 255 / 255, green: 0 / 255, blue: 82 / 255))
                
                Text("\(sliderValue, specifier: "%.0f")Kcal")
                    .font(.system(size: 28, weight: .bold))
                Spacer()
                
                Text(sliderValue >= 150 && sliderValue <= 300 ? "부담없이 운동하고 싶어요" : sliderValue > 300 && sliderValue <= 500 ? "어느 정도는 움직이고 싶어요" : "빡세게 운동해볼래요")
                    .font(.system(size: 17, weight: .medium))
                    .foregroundColor(Color(red: 1, green: 1, blue: 1, opacity: 0.6))
                Spacer()
            }
   
            Spacer()
            Button("다음", action: {
                saveCalorie()
            })
            .buttonStyle(RedButtonStyle())
        }
        .padding(EdgeInsets(top: 30, leading: 30, bottom: 30, trailing: 30))
        .background(Color(red: 30/255, green: 28/255, blue: 29/255)) // 고급진 까만것이 필요할 듯
    }
    
    func saveCalorie() {
        withAnimation(.easeInOut(duration: 0.5)){
            settings.pageNum += 1
        }
    }
}

struct TextUtil {
    func calculateLineSpacing(_ fontsize: Int, _ percent: Double) -> CGFloat { // 수정된 부분
        //(17 * (1425 / 1000) - 17)
        print(CGFloat(Double(fontsize) * (percent / Double(100)) - Double(fontsize)))
        return CGFloat(Double(fontsize) * (percent / Double(100)) - Double(fontsize))
    }
}



struct CalorieSettingView_Previews: PreviewProvider {
    @State var isMember: Bool = true
    
    static var previews: some View {
        CalorieSettingView()
    }
}



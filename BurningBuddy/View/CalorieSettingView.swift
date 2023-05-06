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
    
    var body: some View {
        VStack {
            Text("목표 칼로리를 \n설정해주세요")
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.white)
                .font(.system(size: 30, weight: .bold))
            Text("운동 목표량을 설정해주세요\n나중에도 변경가능해요")
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.white)
                .padding(EdgeInsets(top: 1, leading: 0, bottom: 90, trailing: 0))
            Spacer()

            VStack {
                if sliderValue >= 150 && sliderValue <= 300 {
                    Text("초보자 아잉교 \(sliderValue, specifier: "%.0f")칼로리를 태우시네예")
                } else if sliderValue > 300 && sliderValue <= 500 {
                    Text("중급자 아잉교 \(sliderValue, specifier: "%.0f")칼로리를 태우시네예")
                } else {
                    Text("헬창이시네예 \(sliderValue, specifier: "%.0f")칼로리를 태우시네예")
                }
                
                
                Slider(value: $sliderValue, in: 150...800, step: 1, onEditingChanged: { _ in
                    
                })
                .padding()
            }
            Spacer()
            Button("다음", action: {
                saveCalorie()
            })
            .buttonStyle(NextButtonStyle(colorRed: 255, colorGreen: 45, colorBlue: 85, fontSize: 17))
        }
        .padding(EdgeInsets(top: 30, leading: 30, bottom: 30, trailing: 30))
        .background(Color(red: 30/255, green: 28/255, blue: 29/255)) // 고급진 까만것이 필요할 듯
    }
    
    func saveCalorie() {
        withAnimation(.easeInOut(duration: 0.4)){
            settings.pageNum += 1
        }
    }
}

struct CalorieSettingView_Previews: PreviewProvider {
    @State var isMember: Bool = true
    
    static var previews: some View {
        CalorieSettingView()
    }
}



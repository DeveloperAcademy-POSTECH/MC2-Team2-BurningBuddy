//
//  SettingView.swift
//  BurningBuddy
//
//  Created by 김동현 on 2023/05/02.
//

import Foundation
import SwiftUI
/**
 settings에 있는 변수들의 값들을 그냥 보여주면 된다.
 단, update 할 수 있는 변수가,,, 칼로리가 있기 때문에, 그것만 업데이트 시키는 코드를 만들어서 넣어주어야 한다.
 */
struct SettingView: View {
    @EnvironmentObject var settings: UserSettings
    
    var body: some View {
        List {
            Section {
                HStack{
                    VStack {
                        Image("Bunny_\(settings.level)_side")
                            .resizable()
                            .frame(width: 94, height: 79)
                        
                    }
                    VStack (alignment: .leading){
                        Text(settings.nickName)
                            .foregroundColor(.white)
                            .font(.system(size: 21, weight: .bold))
                        Text(settings.characterName)
                    }.padding(12)
                }
            }
            .listRowBackground(Color.mainSection2)
            Section {
                
                HStack{
                    Image(systemName: "dumbbell.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 15)
                        .padding(5)
                        .frame(width: 23, height: 23)
                        .background(Color.bunnyColor)
                        .cornerRadius(7)
                        .clipped()
                    Text("모은 핑크 덤벨 개수")
                    Spacer()
                    Text(String(settings.totalDumbbell)+"개")
                        .foregroundColor(.gray)
                }
                
            }
            .listRowBackground(Color.mainSection2)
            Section {
                NavigationLink{
                    CalorieSettingView(sliderValue: Double(settings.goalCalories), isTopButtonHidden: true)
                } label: {
                    HStack{
                        Image(systemName: "checkmark.seal.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 13)
                            .padding(5)
                            .background(Color.bunnyColor)
                            .cornerRadius(7)
                            .clipped()
                        Text("목표 칼로리")
                        Spacer()
                        Text(String(settings.goalCalories) + "Kcal")
                            .foregroundColor(Color.bunnyColor)
                    }
                }
                NavigationLink{
                    NicknameSettingView(isTopButtonHidden: true)
                } label: {
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 13)
                        .padding(5)
                        .background(Color.bunnyColor)
                        .cornerRadius(7)
                        .clipped()
                    Text("닉네임 변경하기")
                }
                NavigationLink{
                    CharacterSettingView(isTopButtonHidden: true)
                } label: {
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 13)
                        .padding(5)
                        .background(Color.bunnyColor)
                        .cornerRadius(7)
                        .clipped()
                    Text("캐릭터이름 변경하기")
                }
            }
            .listRowBackground(Color.mainSection2)
        }
        .navigationTitle("내 정보")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color.backgroundColor)
        .scrollContentBackground(.hidden)
    } // body End
}




struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
            .environmentObject(UserSettings())
    }
}

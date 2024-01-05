//
//  SettingView.swift
//  BurningBuddy
//
//  Created by 김동현 on 2023/05/02.
//

import SwiftUI

/**
 Image 관련된 modifier만 수정해주면 됨.
 중복 코드가 많기 때문에 줄이기만 하면됨.
 다만, Onboarding의 파일들을 재사용하고 있는데, 이것을 리팩토링함에 따라 생기는 side effect 대처 필요.
 settings 관련한 문제도 해결해야 함.
 */
struct SettingView: View {
    @ObservedObject var userModel: UserModel
    @ObservedObject var bunnyModel: BunnyModel
    @State var pageNum = 4 // 세팅뷰들 재사용을 위한 변수
    @State var isFirst = false // 세팅뷰들 재사용을 위한 변수
    
    var body: some View {
        List {
            Section {
                HStack{
                    VStack {
                        Image("Bunny_\(bunnyModel.bunnyLevel)_side")
                            .resizable()
                            .frame(width: 94, height: 79)
                        
                    }
                    VStack (alignment: .leading){
                        Text(userModel.userName)
                            .foregroundColor(.white)
                            .font(.system(size: 21, weight: .bold))
                        Text(bunnyModel.bunnyName)
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
                    Text(String(userModel.totalDumbbell)+"개")
                        .foregroundColor(.gray)
                }
                
            }
            .listRowBackground(Color.mainSection2)
            
            Section {
                NavigationLink(destination: {
                    CalorieSettingView(userModel: userModel, bunnyModel: bunnyModel, sliderValue: Double(userModel.goalCalories), isTopButtonHidden: true, pageNum: $pageNum, isFirst: $isFirst)
                }) {
                    HStack {
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
                        Text(String(userModel.goalCalories) + "kcal")
                            .foregroundColor(Color.bunnyColor)
                    }
                }
                
                NavigationLink(destination: {
                    NicknameSettingView(userModel: userModel, isTopButtonHidden: true, pageNum: $pageNum)
                }) {

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
                
                NavigationLink(destination: {
                    CharacterSettingView(bunnyModel: bunnyModel, isTopButtonHidden: true, pageNum: $pageNum)
                }) {
                    
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
    @ObservedObject static var userModel = UserModel()
    @ObservedObject static var bunnyModel = BunnyModel()
    
    static var previews: some View {
        SettingView(userModel: userModel, bunnyModel: bunnyModel)
    }
}

//
//  MainView.swift
//  BurningBuddy
//
//  Created by 김동현 on 2023/05/02.
//

import Foundation
import SwiftUI

struct MainView: View {
    @EnvironmentObject var settings: UserSettings
    @State var daysleft: Int = 0
    @State var showEvolution = false // 진화과정 모달에 관련된 상태
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    HStack {
                        Text(settings.nickName)
                            .font(.system(size: 25, weight: .bold, design: .default))
                        Text("님의")
                            .font(.system(size: 25, design: .default))
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text(settings.characterName)
                        .foregroundColor(.white)
                        .font(.system(size: 30, weight: .bold, design: .default))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    HStack {
                        Text("다음 성장까지")
                            .font(.system(size: 20, design: .default))
                        Text("\(daysleft)일")                        .font(.system(size: 20, weight: .bold, design: .default))
                        Text("남았습니다.")
                            .font(.system(size: 20, design: .default))
                    }.frame(maxWidth: .infinity, alignment: .leading)
                        .padding(EdgeInsets(top: 5, leading: 0, bottom: -5, trailing: 0))
                }
                
                ProgressView(value: 50, total: 100)
                    .scaleEffect(x: 1, y: 4, anchor: .center)
                    .progressViewStyle(LinearProgressViewStyle(tint: Color(red: 255/255, green: 45/255, blue: 85/255)))
                    .padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
                
                Spacer()
                VStack {
                    HStack {
                        Text("1일 째")
                            .frame(width: 65, height: 28)
                            .background(Color(red: 216/255, green: 216/255, blue: 216/255))
                            .foregroundColor(.black)
                            .cornerRadius(14)
                        
                        Spacer()
                        Button("다음 진화", action: {
                            self.showEvolution = true
                        })
                        .frame(width: 65, height: 28)
                        .background(Color(red: 216/255, green: 216/255, blue: 216/255))
                        .foregroundColor(.black)
                        .cornerRadius(14)
                        .sheet(isPresented: self.$showEvolution) {
                            EvolutionModalView()
                        }
                    }
                    .padding(EdgeInsets(top: 20, leading: 20, bottom: -35, trailing: 20))
                    Circle()
                        .frame(width: 200, height: 300)
                        .scaledToFill()
                        .padding(EdgeInsets(top: -30, leading: 0, bottom: 0, trailing: 0))
                }
                .background(Color(red: 40/255, green: 48/255, blue: 49/255))
                .cornerRadius(20)
                .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
                
                
                HStack {
                    VStack {
                        Spacer()
                        Text("🔥")
                            .font(.system(size: 20, design: .default))
                        Spacer()
                        Text("소모 칼로리")
                            .font(.system(size: 20, design: .default))
                        Spacer()
                        Text(settings.isDoneWorkout ? "342kcal" : "오늘 안함")
                            .font(.system(size: 25, weight: .bold, design: .default))
                        Spacer()
                    }
                    .frame(maxWidth: .infinity,  maxHeight: .infinity, alignment: .center)
                    .background(Color(red: 40/255, green: 48/255, blue: 49/255))
                    .cornerRadius(20)
                    
                    VStack {
                        Spacer()
                        Text("⏱️")
                            .font(.system(size: 20, design: .default))
                        Spacer()
                        Text("운동 시간")
                            .font(.system(size: 20, design: .default))
                        Spacer()
                        Text(settings.isDoneWorkout ? "2 Hours" : "오늘 안함")
                            .font(.system(size: 25, weight: .bold, design: .default))
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    .background(Color(red: 40/255, green: 48/255, blue: 49/255))
                    .cornerRadius(20)
                }
                .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                Spacer()
                
                NavigationLink(destination: {
                    if settings.hasPartner {
                        SearchPartnerView().environmentObject(settings)
                    } else {
                        WorkoutView().environmentObject(settings)
                    }
                } ) {
                    Text(settings.hasPartner ? "운동 시작하기" : "운동 종료하기")
                }
                .buttonStyle(RedButtonStyle())
            }
            .padding(EdgeInsets(top: 50, leading: 30, bottom: 30, trailing: 30))
            .background(Color(red: 30/255, green: 28/255, blue: 29/255)) // 고급진 까만것이 필요할 듯
            
        }
        
    }
    
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView().environmentObject(UserSettings())
            .preferredColorScheme(.dark)
    }
}

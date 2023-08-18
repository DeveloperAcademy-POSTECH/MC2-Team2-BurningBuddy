//
//  UserModel.swift
//  BurningBuddy
//
//  Created by 김동현 on 2023/08/17.
//

import Foundation

class UserModel: ObservableObject {
    final let entityName = "User"
    static let shared = UserModel()
    private let coreDataManager = CoreDataManager.shared
    @Published var userName = ""
    @Published var todayCalories = 0
    @Published var todayWorkoutHours = 0
    @Published var totalDumbbell = 0
    @Published var goalCalories = 0
    @Published var userID: UUID = UUID()
    
    private init() {
        fetchUserData()
    }
    
    func fetchUserData() {
        let fetchResult = coreDataManager.fetch(entityName: entityName)
        
        guard let userData = fetchResult.first as? User else {
            print("유저 데이터를 가져오는데 실패했습니다.(UserModel)")
            return
        }
        
        userName = userData.userName ?? ""
        todayCalories = Int(userData.todayCalories)
        todayWorkoutHours = userData.todayWorkoutHours
        totalDumbbell = Int(userData.totalDumbbell)
        goalCalories = Int(userData.goalCalories)
        
    }
    
}

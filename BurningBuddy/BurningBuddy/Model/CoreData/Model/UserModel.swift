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
    
    init() {
        fetchUserData()
    }
    
    func createUserData() {
        if let newUserData = coreDataManager.create(entityName: entityName, attributes: [:]) as? User {
            
            let fetchReslut = coreDataManager.fetch(entityName: entityName)
            if let currentUserData = fetchReslut.first as? User {
                currentUserData.userName = userName
                currentUserData.todayCalories = Int16(todayCalories)
                currentUserData.todayWorkoutHours = Int16(todayWorkoutHours)
                currentUserData.totalDumbbell = Int16(totalDumbbell)
                currentUserData.goalCalories = Int16(goalCalories)
                currentUserData.userID = userID
            }
            
            coreDataManager.update(object: newUserData)
        }
    }
    
    func fetchUserData() {
        let fetchResult = coreDataManager.fetch(entityName: self.entityName)
        
        guard let userData = fetchResult.first as? User else {
            print("유저 데이터를 가져오는데 실패했습니다.(UserModel)")
            return
        }
        
        userName = userData.userName ?? ""
        todayCalories = Int(userData.todayCalories)
        todayWorkoutHours = Int(userData.todayWorkoutHours)
        totalDumbbell = Int(userData.totalDumbbell)
        goalCalories = Int(userData.goalCalories)
        userID = userData.userID ?? UUID()
    }
    
    func saveUserData() {
        var userData: User?
        
        let fetchResult = coreDataManager.fetch(entityName: entityName)
        if let existingUserData = fetchResult.first as? User {
            userData = existingUserData
        } else if let newUserData = coreDataManager.create(entityName: entityName, attributes: [:]) as? User {
            userData = newUserData
        }
        
        guard let user = userData else {
            print("유저 데이터 생성 또는 찾기에 실패했습니다.")
            return
        }
        
        userName = user.userName ?? ""
        todayCalories = Int(user.todayCalories)
        todayWorkoutHours = Int(user.todayWorkoutHours)
        totalDumbbell = Int(user.totalDumbbell)
        goalCalories = Int(user.goalCalories)
        userID = user.userID ?? UUID()
        
        coreDataManager.update(object: user)
    }
    
    func calculateTime(second: TimeInterval) -> String {
        let hour = Int(second / 3600)
        let minute = Int(second.truncatingRemainder(dividingBy: 3600) / 60)
        /*
            01h 01m
            01h 11m
            11h 01m
            11h 11m
         */
        if hour < 10 && minute < 10 {
            return String("0\(hour)h 0\(minute)m")
        }
        else if hour < 10 && minute > 9 {
            return String("0\(hour)h \(minute)m")
        }
        else if hour > 9 && minute < 10 {
            return String("\(hour)h 0\(minute)m")
        }
        else {
            return String("\(hour)h \(minute)m")
        }
    }
}

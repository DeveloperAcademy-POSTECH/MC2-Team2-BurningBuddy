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

        // 기존 workoutHours가 String(ex. 00h 00m)으로 되어 있어 새로운 coreData와 형식을 맞춰주기 위한 코드
        var workoutHours = userData.todayWorkoutHours
        if String(workoutHours).split(separator: " ").count == 2 {
            // 시간과 분을 추출하여 NSNumber로 변환
            let components = String(workoutHours).components(separatedBy: " ")
            if components.count == 2,
               let hours = Int(components[0].replacingOccurrences(of: "h", with: "")),
               let minutes = Int(components[1].replacingOccurrences(of: "m", with: "")) {

                workoutHours = Int16(hours * 60 + minutes)
            } else {
                print("Invalid format for workoutHours")
                // workoutHours 형식이 올바르지 않을 경우 처리
            }
        }

        userName = userData.userName ?? ""
        todayCalories = Int(userData.todayCalories)
        todayWorkoutHours = Int(workoutHours)
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
        
        user.userName = userName
        user.todayCalories = Int16(todayCalories)
        user.todayWorkoutHours = Int16(todayWorkoutHours)
        user.totalDumbbell = Int16(totalDumbbell)
        user.goalCalories = Int16(goalCalories)
        user.userID = userID
        
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

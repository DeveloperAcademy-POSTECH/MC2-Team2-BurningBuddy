//
//  WorkoutModel.swift
//  BurningBuddy
//
//  Created by 김동현 on 2023/08/21.
//

import Foundation

class WorkoutModel: ObservableObject {
    final let entityName = "WorkoutRecord"
    static let shared = WorkoutModel()
    private let coreDataManager = CoreDataManager.shared
    @Published var startTime = Date()
    @Published var endTime = Date()
    @Published var workoutDay = Date()
    @Published var workoutTime = 0
    @Published var calorieBurn = 0
    
    init() {
        fetchWorkoutData()
    }
    
    func createWorkoutData() {
        if let newWorkoutData = coreDataManager.create(entityName: entityName, attributes: [:]) as? BurningRecord {
        
            let fetchReslut = coreDataManager.fetch(entityName: entityName)
            if let currentWorkoutData = fetchReslut.first as? BurningRecord {
            }
            
            coreDataManager.update(object: newWorkoutData)
        }
    }
    
    func fetchWorkoutData() {
        let fetchResult = coreDataManager.fetch(entityName: entityName)
        
        guard let workoutData = fetchResult.first as? BurningRecord else {
            print("유저 데이터를 가져오는데 실패했습니다.(WorkoutModel)")
            return
        }
        
        startTime = workoutData.startTime ?? Date()
        endTime = workoutData.endTime ?? Date()
        workoutDay = workoutData.workoutDay ?? Date()
        workoutTime = Int(workoutData.workoutTime)
        calorieBurn = Int(workoutData.calorieBurn)
    }
    
    func saveWorkoutData() {
        var workoutData: BurningRecord?
        
        let fetchResult = coreDataManager.fetch(entityName: entityName)
        if let existingUserData = fetchResult.first as? BurningRecord {
            workoutData = existingUserData
        } else if let newWorkoutData = coreDataManager.create(entityName: entityName, attributes: [:]) as? BurningRecord {
            workoutData = newWorkoutData
        }
        
        guard let workout = workoutData else {
            print("유저 데이터 생성 또는 찾기에 실패했습니다.")
            return
        }
        
        workout.startTime = startTime
        workout.endTime = endTime
        workout.workoutDay = workoutDay
        workout.workoutTime = Int16(workoutTime)
        workout.calorieBurn = Int16(calorieBurn)
        
        coreDataManager.update(object: workout)
    }
}

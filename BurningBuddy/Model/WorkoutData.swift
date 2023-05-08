//
//  WorkoutData.swift
//  BurningBuddy
//
//  Created by Jay on 2023/05/08.
//

import HealthKit

class WorkoutData: ObservableObject{
    let healthStore = HKHealthStore()
    var workoutStartTime = Date()
    @Published var workoutCalorie = 0
    @Published var workoutDuration = "00:00"
    
    // 권한 요청 함수
    func requestAuthorization(){
        let allTypes = Set([HKObjectType.workoutType()])

        healthStore.requestAuthorization(toShare: allTypes, read: allTypes) { (success, error) in
            if success {
                print("Authorization succeeded.")
            } else {
                print("Authorization failed. Error: \(String(describing: error?.localizedDescription))")
            }
        }
    }
    
}

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
    
    // 운동 시작 시간 기록하는 함수
    func setWorkoutStartTime() {
        self.workoutStartTime = Date()
        
        // 테스트용 (시작하는 하루)
//        let calendar = NSCalendar.current
//        let now = Date()
//        let components = calendar.dateComponents([.year, .month, .day], from: now)
//        self.workoutStartTime = calendar.date(from: components)!
    }
    
    // 운동 끝났을 때 운동기록(칼로리번, 운동시간) 가져오는 함수
    func fetchAfterWorkoutTime() {
        let type = HKObjectType.workoutType()
        let now = Date()
        
        let predicate = HKQuery.predicateForSamples(withStart: workoutStartTime, end: now, options: .strictStartDate)
        
        let query = HKAnchoredObjectQuery(type: type, predicate: predicate, anchor: nil, limit: HKObjectQueryNoLimit) { (query, samples, deletedObjects, anchor, error) in
            
            if let samples = samples as? [HKWorkout], !samples.isEmpty {
                var totalTime: TimeInterval = 0.0
                var totalCalories = 0.0
                for workout in samples {
                    // 운동 시간 총합을 계산
                    totalTime += workout.duration
                    
                    let calorie = workout.statistics(for: HKQuantityType(.activeEnergyBurned))
                    totalCalories += calorie?.sumQuantity()?.doubleValue(for: HKUnit.kilocalorie()) ?? 0.0
                }
                
                DispatchQueue.main.async {
//                    self.workoutDuration = self.calculateTime(second: totalTime)
//                    print(self.calculateTime(second: totalTime))
                    self.workoutCalorie = Int(totalCalories.rounded())
                }
            } else {
                print("Error getting workout data: \(String(describing: error))")
            }
        }
        
        healthStore.execute(query)
    }
}

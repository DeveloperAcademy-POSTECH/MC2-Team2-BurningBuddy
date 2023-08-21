//
//  HealthData.swift
//  BurningBuddy
//
//  Created by Jay on 2023/05/08.
//

import HealthKit

class HealthData: ObservableObject{
    let healthStore = HKHealthStore()
    var workoutStartTime = Date()
    // Property workoutDuration: 총 운동 시간
    // Property workoutCalorie: 운동중 소모한 칼로리
    @Published var workoutDuration = 0
    @Published var workoutCalorie = 0
    
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
    
    // 운동 시작 시간을 기록합니다. (파트너와 운동 시작 전 태그할 때 사용)
    func setWorkoutStartTime() {
        self.workoutStartTime = Date()
        
        // 테스트용 (시작하는 하루)
//                let calendar = NSCalendar.current
//                let now = Date()
//                let components = calendar.dateComponents([.year, .month, .day], from: now)
//                self.workoutStartTime = calendar.date(from: components)!
    }
    
    // 운동 끝났을 때 운동기록(칼로리번, 운동시간)을 가져옵니다.
    func fetchAfterWorkoutTime() {
        let type = HKObjectType.workoutType()
        let now = Date()
        // 파트너와 태그한 이후부터 운동종료 버튼을 누른 순간까지의 운동 기록을 불러오기 위함
        let predicate = HKQuery.predicateForSamples(withStart: workoutStartTime, end: now, options: .strictStartDate)
        
        let query = HKAnchoredObjectQuery(type: type, predicate: predicate, anchor: nil, limit: HKObjectQueryNoLimit) { (query, samples, deletedObjects, anchor, error) in
            
            if let samples = samples as? [HKWorkout], !samples.isEmpty {
                var totalTime: TimeInterval = 0.0
                var totalCalories = 0.0
                for workout in samples {
                    // 운동 시간 총합을 계산
                    totalTime += workout.duration
                    // 운동 소모 칼로리 총합 계산
                    let calorie = workout.statistics(for: HKQuantityType(.activeEnergyBurned))
                    totalCalories += calorie?.sumQuantity()?.doubleValue(for: HKUnit.kilocalorie()) ?? 0.0
                }
                
                DispatchQueue.main.async {
                    self.workoutDuration = Int(totalTime)
                    self.workoutCalorie = Int(totalCalories.rounded())
                }
            } else {
                print("Error getting workout data: \(String(describing: error))")
            }
        }
        healthStore.execute(query)
    }
    
    // 운동 시간을 00h 00m 시간,분에 맞게 변환 해줍니다.
    // Paramaeter second: 운동한 시간 (초 단위)
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

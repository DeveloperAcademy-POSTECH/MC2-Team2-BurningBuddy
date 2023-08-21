//
//  WorkoutRecord+CoreDataProperties.swift
//  BurningBuddy
//
//  Created by 김동현 on 2023/08/21.
//
//

import Foundation
import CoreData


extension WorkoutRecord {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WorkoutRecord> {
        return NSFetchRequest<WorkoutRecord>(entityName: "WorkoutRecord")
    }

    @NSManaged public var calorieBurn: Int16
    @NSManaged public var endTime: Date?
    @NSManaged public var startTime: Date?
    @NSManaged public var workoutDay: Date?
    @NSManaged public var workoutTime: Int16

}

extension WorkoutRecord : Identifiable {

}

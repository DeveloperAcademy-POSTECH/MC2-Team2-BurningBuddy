//
//  Workout+CoreDataProperties.swift
//  BurningBuddy
//
//  Created by 김동현 on 2023/08/21.
//
//

import Foundation
import CoreData


extension Workout {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Workout> {
        return NSFetchRequest<Workout>(entityName: "Workout")
    }

    @NSManaged public var calorieBurn: Int16
    @NSManaged public var endTime: Date?
    @NSManaged public var startTime: Date?
    @NSManaged public var workoutDay: Date?
    @NSManaged public var workoutTime: Int16

}

extension Workout : Identifiable {

}

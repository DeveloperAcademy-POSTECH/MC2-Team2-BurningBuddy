//
//  BurningRecord+CoreDataProperties.swift
//  BurningBuddy
//
//  Created by 김동현 on 2023/08/21.
//
//

import Foundation
import CoreData


extension BurningRecord {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BurningRecord> {
        return NSFetchRequest<BurningRecord>(entityName: "BurningRecord")
    }

    @NSManaged public var calorieBurn: Int16
    @NSManaged public var endTime: Date?
    @NSManaged public var startTime: Date?
    @NSManaged public var workoutDay: Date?
    @NSManaged public var workoutTime: Int16

}

extension BurningRecord : Identifiable {

}

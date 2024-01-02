//
//  User+CoreDataProperties.swift
//  BurningBuddy
//
//  Created by 김동현 on 2023/08/18.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var goalCalories: Int16
    @NSManaged public var todayCalories: Int16
    @NSManaged public var todayWorkoutHours: Int16
    @NSManaged public var totalDumbbell: Int16
    @NSManaged public var userID: UUID?
    @NSManaged public var userName: String?

}

extension User: Identifiable {

}

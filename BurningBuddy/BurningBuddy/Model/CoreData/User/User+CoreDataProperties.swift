//
//  User+CoreDataProperties.swift
//  BurningBuddy
//
//  Created by Bokyung on 2023/05/08.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var userName: String?
    @NSManaged public var todayCalories: Int16
    @NSManaged public var todayWorkoutHours: String
    @NSManaged public var totalDumbbell: Int16
    @NSManaged public var goalCalories: Int16
    @NSManaged public var userID: UUID
}

extension User : Identifiable {

}

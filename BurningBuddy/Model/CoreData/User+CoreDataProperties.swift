//
//  User+CoreDataProperties.swift
//  BurningBuddy
//
//  Created by 박의서 on 2023/05/08.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var userName: String?

}

extension User : Identifiable {

}

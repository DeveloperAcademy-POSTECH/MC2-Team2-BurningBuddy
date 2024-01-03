//
//  Bunny+CoreDataProperties.swift
//  BurningBuddy
//
//  Created by 김동현 on 1/2/24.
//
//

import Foundation
import CoreData


extension Bunny {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Bunny> {
        return NSFetchRequest<Bunny>(entityName: "Bunny")
    }

    @NSManaged public var characterName: String?
    @NSManaged public var level: Int16

}

extension Bunny : Identifiable {

}

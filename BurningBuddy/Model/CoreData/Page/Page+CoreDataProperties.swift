//
//  Page+CoreDataProperties.swift
//  BurningBuddy
//
//  Created by 박의서 on 2023/05/08.
//
//

import Foundation
import CoreData


extension Page {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Page> {
        return NSFetchRequest<Page>(entityName: "Page")
    }

    @NSManaged public var showOnboarding: Bool

}

extension Page : Identifiable {

}

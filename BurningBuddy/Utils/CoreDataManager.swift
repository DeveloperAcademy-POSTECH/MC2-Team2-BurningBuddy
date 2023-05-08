//
//  CoreDataManager.swift
//  BurningBuddy
//
//  Created by 박의서 on 2023/05/08.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    
    static let coreDM = CoreDataManager()

    let persistentContainer: NSPersistentContainer

    init() {
        persistentContainer = NSPersistentContainer(name:"UserDataModel")
        persistentContainer.loadPersistentStores {(description, error) in
            if let error = error {
                fatalError("Core Data Store failed \(error.localizedDescription)")
            }
        }
    }

    func createUser(userName: String) {

      let user = User(context: persistentContainer.viewContext)
      user.userName = userName

        do {
            try persistentContainer.viewContext.save()
        } catch {
            print("Failed to save profile \(error)")
        }
    }
    
    func createBuddy(characterName: String) {

      let bunny = Bunny(context: persistentContainer.viewContext)
      bunny.characterName = characterName

        do {
            try persistentContainer.viewContext.save()
        } catch {
            print("Failed to save profile \(error)")
        }
    }

    func readAllUser() -> [User] {

        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()

        do{
            return try persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            return []
        }

    }

    func readAllBuddy() -> [Bunny] {
        
        let fetchRequest: NSFetchRequest<Bunny> = Bunny.fetchRequest()

        do{
            return try persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            return []
        }

    }

    func updateUser() {

        do{
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback()
        }
    }

    func deleteUser(user: User) {

        persistentContainer.viewContext.delete(user)

        do{
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback()
            print("Failed to save context \(error)")
        }
    }
}


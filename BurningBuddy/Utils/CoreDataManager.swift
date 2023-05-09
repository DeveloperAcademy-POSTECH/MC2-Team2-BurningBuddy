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
    
    func createUser(userName: String, goalCalories: Int16) {
        
        let user = User(context: persistentContainer.viewContext)
        user.userName = userName
        user.goalCalories = goalCalories
        user.todayCalories = 0
        user.todayWorkoutHours = "00:00"
        user.totalDumbbell = 0
        
        do {
            try persistentContainer.viewContext.save()
        } catch {
            print("Failed to save profile \(error)")
        }
    }
    
    func createBunny(characterName: String) {
        
        let bunny = Bunny(context: persistentContainer.viewContext)
        bunny.characterName = characterName
        bunny.level = 1
        
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
    
    func readAllBunny() -> [Bunny] {
        
        let fetchRequest: NSFetchRequest<Bunny> = Bunny.fetchRequest()
        
        do{
            return try persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
    }
    
    func update() {
        
        do{
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback() // 오류나면 오류난 걸 지워버린다. 오류나지 않은 가장 최신의 것을 불러온다.
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


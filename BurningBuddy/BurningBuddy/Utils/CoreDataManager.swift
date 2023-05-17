//
//  CoreDataManager.swift
//  BurningBuddy
//
//  Created by 박의서 on 2023/05/08.
//

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
    
    func createUser() {
        
        let user = User(context: persistentContainer.viewContext)
        user.userName = "김예은"
        user.goalCalories = 200
        user.todayCalories = 0
        user.todayWorkoutHours = "00h 00m"
        user.totalDumbbell = 0
        user.userID = UUID() // 유저 통신시 같은 partner인지 확인하기 위한 UUID
        
        do {
            try persistentContainer.viewContext.save()
        } catch {
            print("Failed to save profile \(error)")
        }
    }
    
    func createBunny() {
        
        let bunny = Bunny(context: persistentContainer.viewContext)
        bunny.characterName = "이동재"
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


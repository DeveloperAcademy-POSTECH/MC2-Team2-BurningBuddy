//
//  CoreDataManager.swift
//  BurningBuddy
//
//  Created by 박의서 on 2023/05/08.
//

import CoreData
import UIKit

class CoreDataManager {
    
    static let shared = CoreDataManager()

    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "UserInfo")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error)")
            }
        }
        return container
    }()
    
    private var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    // MARK: - CRUD 메서드
    /**
     각각의 Entity에 해당하는 메서드들을 CoreDataManager 내부에서 제어하는 것이 아니라,
     DataModel에서 제어하기 위해 CoreDataManager에서 사용하는 메서드는
     UserDataModel 그 자체에 접근하기 위한 메서드만 남겨놓음.
     */
    
    func create(entityName: String, attributes: [String: Any]) -> NSManagedObject? {
        guard let entity = NSEntityDescription.entity(forEntityName: entityName, in: context) else {
            return nil
        }
        
        let object = NSManagedObject(entity: entity, insertInto: context)
        object.setValuesForKeys(attributes)
        
        do {
            try context.save()
            return object
        } catch {
            print("Failed to create object(CoreDataManager): \(error)")
            return nil
        }
    }
    
    func fetch(entityName: String, predicate: NSPredicate? = nil) -> [NSManagedObject] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchRequest.predicate = predicate
        
        do {
            let result = try context.fetch(fetchRequest)
            return result as? [NSManagedObject] ?? []
        } catch {
            print("Failed to fetch objects(CoreDataManager): \(error)")
            return []
        }
    }
    
    func update(object: NSManagedObject) {
        do {
            try context.save()
        } catch {
            print("Failed to update object(CoreDataManager): \(error)")
        }
    }
    
    func delete(object: NSManagedObject) {
        context.delete(object)
        
        do {
            try context.save()
        } catch {
            print("Failed to delete object(CoreDataManager): \(error)")
        }
    }
    
    
    /**
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
    */
}


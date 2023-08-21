//
//  BunnyModel.swift
//  BurningBuddy
//
//  Created by 김동현 on 2023/08/17.
//

import Foundation

class BunnyModel: ObservableObject {
    final let entityName = "Bunny"
    static let shared = BunnyModel()
    private let coreDataManager = CoreDataManager.shared
    @Published var bunnyName = ""
    @Published var bunnyLevel = 0
    
    init() {
        fetchUserData()
    }
    
    func createBunnyData() {
        if let newBunnyData = coreDataManager.create(entityName: entityName, attributes: [:]) as? Bunny {
        
            let fetchReslut = coreDataManager.fetch(entityName: entityName)
            if let currentUserData = fetchReslut.first as? Bunny {
                currentUserData.characterName = bunnyName
                currentUserData.level = Int16(bunnyLevel)
            }
            
            coreDataManager.update(object: newBunnyData)
        }
    }
    
    func fetchUserData() {
        let fetchResult = coreDataManager.fetch(entityName: entityName)
        
        guard let bunnyData = fetchResult.first as? Bunny else {
            print("유저 데이터를 가져오는데 실패했습니다.(UserModel)")
            return
        }
        
        bunnyName = bunnyData.characterName ?? "버닝버디"
        bunnyLevel = Int(bunnyData.level)
    }
    
    func saveUserData() {
        var bunnyData: Bunny?
        
        let fetchResult = coreDataManager.fetch(entityName: entityName)
        if let existingUserData = fetchResult.first as? Bunny {
            bunnyData = existingUserData
        } else if let newBunnyData = coreDataManager.create(entityName: entityName, attributes: [:]) as? Bunny {
            bunnyData = newBunnyData
        }
        
        guard let bunny = bunnyData else {
            print("유저 데이터 생성 또는 찾기에 실패했습니다.")
            return
        }
        
        bunny.characterName = bunnyName
        bunny.level = Int16(bunnyLevel)
        
        coreDataManager.update(object: bunny)
    }
}

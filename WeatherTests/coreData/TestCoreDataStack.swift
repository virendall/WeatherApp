//
//  TestCoreDataStack.swift
//  WeatherTests
//
//  Created by Virender Dall on 08/09/21.
//
import Weather
import CoreData

class TestCoreDataStack: CoreDataStack {
    
    override init() {
        super.init()
        let persistentStoreDescription = NSPersistentStoreDescription()
        persistentStoreDescription.type = NSInMemoryStoreType
        
        // 2
        let container = NSPersistentContainer(name: CoreDataStack.modelName)
        container.persistentStoreDescriptions = [persistentStoreDescription]
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        persistentContainer = container
    }
}

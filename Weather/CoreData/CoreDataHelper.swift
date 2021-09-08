//
//  CoreDataHelper.swift
//  Receipe-App
//
//  Created by Virender Dall on 06/11/20.
//  Copyright © 2020 Virender Dall. All rights reserved.
//

import UIKit

import Foundation
import CoreData

class CoreDataHelper {
    
    let context: NSManagedObjectContext
    let coreDataStack: CoreDataStack

    // MARK: - Initializers
    public init(managedObjectContext: NSManagedObjectContext, coreDataStack: CoreDataStack) {
      self.context = managedObjectContext
      self.coreDataStack = coreDataStack
    }
    
    func addRecord<T: NSManagedObject>(_ type : T.Type) -> T {
        let entityName = T.description()
        let entity = NSEntityDescription.entity(forEntityName: entityName, in: context)
        let record = T(entity: entity!, insertInto: context)
        return record
    }
    
    func allRecords<T: NSManagedObject>(_ type : T.Type, sort: NSSortDescriptor? = nil) -> [T] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: T.description())
        if let sortDescriptor = sort {
            request.sortDescriptors = [sortDescriptor]
        }
        do {
            let results = try context.fetch(request)
            return results as! [T]
        } catch
        {
            print("Error with request: \(error)")
            return []
        }
    }
    
    func deleteRecord(_ object: NSManagedObject) {
        context.delete(object)
    }
    
    func saveDatabase() {
        coreDataStack.saveContext()
    }
    
}


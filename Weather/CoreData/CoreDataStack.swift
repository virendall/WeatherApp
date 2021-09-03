
import Foundation
import CoreData

public class CoreDataStack {
    
    
    fileprivate static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Weather")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    fileprivate static var saveManageObjectContext:NSManagedObjectContext = {
        return persistentContainer.newBackgroundContext()
    }()
    
    static var managedObjectContext: NSManagedObjectContext = {
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.parent = saveManageObjectContext
        return managedObjectContext
    }()
    
    // MARK: - Core Data Saving support
    
    static func saveContext() {
        guard managedObjectContext.hasChanges || saveManageObjectContext.hasChanges else {
            return;
        }
        managedObjectContext.performAndWait {
            do {
                try managedObjectContext.save()
            } catch {
                let nserror = error as NSError
                print("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
        
        saveManageObjectContext.perform {
            do {
                try saveManageObjectContext.save()
            } catch {
                let nserror = error as NSError
                print("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}


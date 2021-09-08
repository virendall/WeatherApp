
import Foundation
import CoreData

open class CoreDataStack {
    
    public static let modelName = "Weather"
    
    public init() {
    }
    
    public lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: CoreDataStack.modelName)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var saveManageObjectContext:NSManagedObjectContext = {
        return persistentContainer.newBackgroundContext()
    }()
    
    public lazy var managedObjectContext: NSManagedObjectContext = {
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.parent = saveManageObjectContext
        return managedObjectContext
    }()
    
    // MARK: - Core Data Saving support
    
    public func saveContext() {
        guard managedObjectContext.hasChanges || saveManageObjectContext.hasChanges else {
            return;
        }
        managedObjectContext.performAndWait {[weak self] in
            do {
                try self?.managedObjectContext.save()
            } catch {
                let nserror = error as NSError
                print("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
        
        saveManageObjectContext.perform {[weak self] in
            do {
                try self?.saveManageObjectContext.save()
            } catch {
                let nserror = error as NSError
                print("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}


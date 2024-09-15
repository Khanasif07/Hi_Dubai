//
//  PersistentStorage.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 15/09/2024.
//

import Foundation
import CoreData

final class PersistentStorage
{

    private init(){}
    static let shared = PersistentStorage()

    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "Hi_Dubai")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {

                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    lazy var context = persistentContainer.viewContext
    // MARK: - Core Data Saving support
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    func fetchManagedObject<T: NSManagedObject>(managedObject: T.Type) -> [T]?
    {

//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CDEmployee")
//        let fetchSort = NSSortDescriptor(key: "name", ascending: true)
//        fetchRequest.sortDescriptors = [fetchSort]

        do {
            guard let result = try PersistentStorage.shared.context.fetch(managedObject.fetchRequest()) as? [T] else {return nil}
            return result

        } catch let error {
            debugPrint(error)
        }

        return nil
    }
    
    func printDocumentDirectoryPath() {
       debugPrint(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0])
    }
}

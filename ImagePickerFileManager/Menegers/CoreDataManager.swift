//
//  CoreDataManager.swift
//  ImagePickerFileManager
//
//  Created by Леонід Шевченко on 16.08.2022.
//

import Foundation
import CoreData

struct CoreDataManager {
    
    static let shared = CoreDataManager()
    
    private init() {}

    // MARK: Save Objects to Core Data
    func cdSave(_ context: NSManagedObjectContext) {
        do {
            try context.save()
        }
        catch {
            print("Error while Core Data try to save Object")
        }
    }

    // MARK: Clear Database from Core Data objects
    func cdTryDeleteAllObjects(context: NSManagedObjectContext, completion: @escaping(() -> Void)) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "CDPhoto")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(deleteRequest)
            completion()
        } catch let error as NSError {
            print("Error while Core Data try delete all objects")
        }
    }
    
    // MARK: Delete exact Core Data Object
    func deleteCoreDataObjct(object: NSManagedObject, context: NSManagedObjectContext, completion: @escaping(() -> Void)) {
        // Remove the present
        context.delete(object)
        
        // Save the data
        do {
            try context.save()
        }
        catch {
            print("Error while delete one of the Core Data bjects")
        }
        completion()
    }
}

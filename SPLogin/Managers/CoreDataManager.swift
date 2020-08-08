//
//  CoreDataManager.swift
//  SPLogin
//
//  Created by Arnaud Barragao on 02/08/2020.
//  Copyright © 2020 abarragao. All rights reserved.
//

import UIKit
import CoreData

struct CoreDataManager {
    
    let userEntity = "UserEntity"
    
    public static let shared = CoreDataManager()
    
    private init(){}
    
    var context : NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        return context
    }

    // MARK: - Core Data Saving support
    func saveContext () {
        if self.context.hasChanges {
            do {
                try self.context.save()
            } catch {
//                let nserror = error as NSError
                print(error)
            }
        }
    }
    
    func getUser(completion:@escaping (User?) ->()){
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: self.userEntity)
        request.returnsObjectsAsFaults = false
        do {
            let result = try self.context.fetch(request)
            if let userEntity = result.first as? UserEntity {
                completion(nil)
            }
            
        } catch {
            completion(nil)
        }
    }
    
    func deleteAllData() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: userEntity)
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try context.fetch(fetchRequest)
            for object in results {
                guard let objectData = object as? NSManagedObject else {continue}
                context.delete(objectData)
                saveContext()
            }
        } catch let error {
            print("Detele all data in \(userEntity) error :", error)
        }
    }
}

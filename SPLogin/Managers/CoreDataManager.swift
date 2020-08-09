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
    let pictureEntity = "PictureEntity"
    
    public static let shared = CoreDataManager()
    
    private init(){}
    
    var context : NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        context.mergePolicy = NSOverwriteMergePolicy
        return context
    }

    // MARK: - Core Data Saving support
    func saveContext () {
        if self.context.hasChanges {
            do {
                try self.context.save()
            } catch {
                print(error)
            }
        }
    }
    
    //MARK: User
    func getUser(completion:@escaping (User?) ->()){
        
        self.getUserEntity { (userEntity) in
            if let userEntity = userEntity,
                let user = User.decode(userEntity.getData()){
                completion(user)
            }
            else{
                completion(nil)
            }
        }
    }
    
    func getUserEntity(completion: @escaping(UserEntity?) ->()){
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: self.userEntity)
        request.returnsObjectsAsFaults = false
        do {
            let result = try self.context.fetch(request)
            if let userEntity = result.first as? UserEntity{
                completion(userEntity)
            }
            else{
                completion(nil)
            }
            
        } catch {
            completion(nil)
        }
    }
    
    func saveUser(_ user: User){
        UserEntity.insert(user)
        self.saveContext()
    }
    
    //MARK: Picture
    //Pas de relation car sinon l'image peut se retrouver ecrasé par un valeur null.
    func savePicture(_ data:Data, userId:Int){
        self.getUserEntity { (userEntity) in
            guard userEntity != nil else{
                return
            }
            
            PictureEntity.insert(data, userId:userId)
            self.saveContext()
        }
    }
    
    func getPicture(userId: Int? = nil, completion: @escaping (PictureEntity?,Data?) ->()){
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: self.pictureEntity)
        if userId != nil{
            request.predicate = NSPredicate.init(format: "userId == %i", userId!)
        }
        request.returnsObjectsAsFaults = false
        do {
            let result = try self.context.fetch(request)
            if let picture = result.first as? PictureEntity,
                let data = picture.value(forKey: "data") as? Data{
                completion(picture, data)
            }
            else{
                completion(nil, nil)
            }
            
        } catch {
            completion(nil, nil)
        }
    }
    
    //MARK: Delete
    //Comme l'image n'est pas stocké via l'api on ne la suppr pas de l'app.
    func deleteAllData() {
        self.getUserEntity {(userEntity) in
            if userEntity != nil {
                self.context.delete(userEntity!)
            }
        }        
    }
}

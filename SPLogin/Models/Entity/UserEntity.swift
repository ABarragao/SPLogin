//
//  UserEntity.swift
//  SPLogin
//
//  Created by Arnaud Barragao on 03/08/2020.
//  Copyright © 2020 abarragao. All rights reserved.
//

import Foundation
import CoreData

class UserEntity: NSManagedObject {  
    static func insert(_ user: User){
        let context = CoreDataManager.shared.context
        let entityName = "UserEntity"
        let entityDesc = NSEntityDescription.entity(forEntityName: entityName,
        in: context)!
        let newUser = NSManagedObject(entity: entityDesc, insertInto: context)
        
        newUser.setValue(user.firstname, forKeyPath: "firstname")
        newUser.setValue(user.lastname, forKeyPath: "lastname")
        newUser.setValue(user.id, forKeyPath: "id")
        newUser.setValue(user.email, forKeyPath: "email")
        newUser.setValue(user.birthdayDate, forKeyPath: "birthday_date")
        newUser.setValue(user.shortName, forKey: "short_name")
        newUser.setValue(user.gender, forKeyPath: "gender")
        newUser.setValue(user.phone, forKeyPath: "phone")
        
        let address = AddressEntity(user.address!)
        newUser.setValue(address, forKeyPath: "address")
        
        let kpi = KPIEntity(user.kpi!)
        newUser.setValue(kpi, forKeyPath: "kpi")
    }
    
    func getData() -> Data? {
        let dict: [String: Any] = self.getDictValue(withRelation: true)
        
        let data = try? JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
        return data
    }
}

class AddressEntity: NSManagedObject {
    
    override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
    
    init(_ address: Address){
        let context = CoreDataManager.shared.context
        let entityName = "AddressEntity"
        let entityDesc = NSEntityDescription.entity(forEntityName: entityName,
                                                    in: context)!
        super.init(entity: entityDesc, insertInto: context)
        
        self.setValue(address.city, forKeyPath: "city")
        self.setValue(address.country, forKeyPath: "country")
        self.setValue(address.street, forKeyPath: "street")
        self.setValue(address.zipCode, forKeyPath: "zip_code")
        
        let geoPoint = GeoPointEntity(address.geoPoint!)
        self.setValue(geoPoint, forKeyPath: "geo_point")
    }
}

class GeoPointEntity: NSManagedObject {
    
    override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
    
    init(_ geoPoint: GeoPoint){
        let context = CoreDataManager.shared.context
        let entityName = "GeoPointEntity"
        let entityDesc = NSEntityDescription.entity(forEntityName: entityName,
                                                    in: context)!
        super.init(entity: entityDesc, insertInto: context)
        
        self.setValue(geoPoint.latitude, forKeyPath: "latitude")
        self.setValue(geoPoint.longitude, forKeyPath: "longitude")
    }
}

class KPIEntity: NSManagedObject {
    
    override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
    
    init(_ kpi: KPI){
        let context = CoreDataManager.shared.context
        let entityName = "KPIEntity"
        let entityDesc = NSEntityDescription.entity(forEntityName: entityName,
                                                    in: context)!
        super.init(entity: entityDesc, insertInto: context)
        
        self.setValue(kpi.reactivenessPercentage, forKeyPath: "reactiveness_percentage")
        self.setValue(kpi.feedbackAverage, forKeyPath: "feedback_average")
        self.setValue(kpi.id, forKeyPath: "id")
        self.setValue(kpi.countJobsDone, forKeyPath: "count_jobs_done")
        self.setValue(kpi.countJobsBackup, forKeyPath: "count_jobs_backup")
        self.setValue(kpi.countYellowCard, forKeyPath: "count_yellow_card")
    }
}

class PictureEntity: NSManagedObject {
    
    override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
    
    
    static func insert(_ data:Data, userId:Int){
        let context = CoreDataManager.shared.context
        let entityName = "PictureEntity"
        let entityDesc = NSEntityDescription.entity(forEntityName: entityName,
                                                    in: context)!
        let newPicture = NSManagedObject(entity: entityDesc, insertInto: context)
        
        newPicture.setValue(data, forKeyPath: "data")
        newPicture.setValue(userId, forKey: "userId")
    }
}

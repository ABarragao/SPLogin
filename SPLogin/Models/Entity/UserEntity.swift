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
        
        newUser.setValue(user.firstname, forKeyPath: "firstName")
        newUser.setValue(user.lastname, forKeyPath: "lastName")
        newUser.setValue(user.id, forKeyPath: "id")
        newUser.setValue(user.email, forKeyPath: "email")
        newUser.setValue(user.birthdayDate, forKeyPath: "birthDate")
        newUser.setValue(user.interviewedAtDate, forKeyPath: "interviewedDate")
        newUser.setValue(user.gender, forKeyPath: "gender")
        newUser.setValue(user.hasAssurance, forKeyPath: "hasAssurance")
        newUser.setValue(user.hasToRenewContract, forKeyPath: "hasToRenewContract")
        newUser.setValue(user.hasToSignContract, forKeyPath: "hasToSignContract")
        newUser.setValue(user.phone, forKeyPath: "phone")
        newUser.setValue(user.state, forKeyPath: "state")
        newUser.setValue(user.status, forKeyPath: "status")
        
        let address = AddressEntity(user.address!)
        newUser.setValue(address, forKeyPath: "address")
        
        let kpi = KPIEntity(user.kpi!)
        newUser.setValue(kpi, forKeyPath: "kpi")
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
        self.setValue(address.zipCode, forKeyPath: "zipCode")
        
        let geoPoint = GeoPointEntity(address.geoPoint!)
        self.setValue(geoPoint, forKeyPath: "geoPoint")
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
        
        self.setValue(kpi.reactivenessPercentage, forKeyPath: "reactivnessPrctg")
        self.setValue(kpi.feedbackAverage, forKeyPath: "feedbackAvg")
        self.setValue(kpi.id, forKeyPath: "id")
        self.setValue(kpi.countJobsDone, forKeyPath: "jobsDone")
        self.setValue(kpi.countJobsBackup, forKeyPath: "jobsBackUp")
        self.setValue(kpi.countYellowCard, forKeyPath: "yellowCard")
        self.setValue(kpi.dateFirstJob, forKeyPath: "firstJobDate")
    }
}

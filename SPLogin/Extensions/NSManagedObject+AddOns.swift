//
//  NSManagedObject+AddOns.swift
//  SPLogin
//
//  Created by Arnaud Barragao on 08/08/2020.
//  Copyright © 2020 abarragao. All rights reserved.
//

import CoreData

extension NSManagedObject{
    func getDictValue(withRelation:Bool)->[String:Any]{
        var dict: [String: Any] = [:]
        for attribute in self.entity.attributesByName {
            if var value = self.value(forKey: attribute.key) {
                if let date = value as? Date{
                   value = DateFormatter.apiFormat.string(from: date)
                }
                dict[attribute.key] = value
            }
        }
        
        if withRelation {
            for relation in self.entity.relationshipsByName{
                if let value = self.value(forKey: relation.key) as? NSManagedObject{
                    let relationDict = value.getDictValue(withRelation: false)
                    dict[relation.key] = relationDict
                }
            }
        }
        
        return dict
    }
}

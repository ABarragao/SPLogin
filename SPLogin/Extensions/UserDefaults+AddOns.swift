//
//  UserDefaults+AddOns.swift
//  SPLogin
//
//  Created by Arnaud Barragao on 02/08/2020.
//  Copyright © 2020 abarragao. All rights reserved.
//

import Foundation

let tokenKey = "tokenKey"

extension UserDefaults {
    func saveToken(_ token : String){
        self.setValue(token, forKey: tokenKey)
    }
    
    func getToken() -> String?{
        return self.value(forKey: tokenKey) as? String
    }
    
    func removeToken(){
        self.setValue(nil, forKey: tokenKey)
    }
}

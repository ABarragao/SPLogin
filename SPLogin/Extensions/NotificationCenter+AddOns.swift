//
//  NotificationCenter+AddOns.swift
//  SPLogin
//
//  Created by Arnaud Barragao on 08/08/2020.
//  Copyright © 2020 abarragao. All rights reserved.
//

import Foundation

let kNotifReachable = "kNotifReachable"

extension NotificationCenter{
    
    func registerToReachability(observer: Any, selector: Selector){
        NotificationCenter.default.addObserver(observer, selector:selector, name: NSNotification.Name(rawValue: kNotifReachable), object: nil)
    }
    
    func sendReachabilityNotif(){
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: kNotifReachable), object: nil)
    }
}

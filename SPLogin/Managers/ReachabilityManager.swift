//
//  ReachabilityManager.swift
//  SPLogin
//
//  Created by Arnaud Barragao on 08/08/2020.
//  Copyright © 2020 abarragao. All rights reserved.
//

import Foundation
import Reachability

class ReachabilityManager: NSObject{
    static let shared = ReachabilityManager()
    var reachability: Reachability!
    var isReachable: Bool = false
    private override init(){
        super.init()
    }
    
    func start(){
        do {
            try reachability = Reachability()
            NotificationCenter.default.addObserver(self, selector: #selector(self.reachabilityChanged(_:)), name: Notification.Name.reachabilityChanged, object: reachability)
            try reachability.startNotifier()
        } catch {
            print("This is not working.")
        }
    }
    
    @objc func reachabilityChanged(_ note: NSNotification) {
        let reachability = note.object as! Reachability
        if reachability.connection != .unavailable {
            isReachable = true
            NotificationCenter.default.sendReachabilityNotif()
        } else {
            isReachable = false
            NotificationCenter.default.sendNoReachabilityNotif()
        }
    }
}

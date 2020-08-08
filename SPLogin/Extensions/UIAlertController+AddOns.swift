//
//  UIAlertController+AddOns.swift
//  SPLogin
//
//  Created by Arnaud Barragao on 08/08/2020.
//  Copyright © 2020 abarragao. All rights reserved.
//

import UIKit

extension UIAlertController{
    static func getNoInternetAlert() -> UIAlertController{
        let alert = UIAlertController.init(title:"reachability.alert.title".localized() , message: "reachability.alert.message".localized(), preferredStyle: .alert)
        let button = UIAlertAction.init(title: "reachability.alert.button".localized(), style: .cancel, handler: nil)

        alert.addAction(button)
        
        return alert
    }
}

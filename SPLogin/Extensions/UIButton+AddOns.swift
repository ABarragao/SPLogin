//
//  UIButton+AddOns.swift
//  SPLogin
//
//  Created by Arnaud Barragao on 07/08/2020.
//  Copyright © 2020 abarragao. All rights reserved.
//

import UIKit

extension UIButton {
    func enable(){
        self.alpha = 1
        self.isUserInteractionEnabled = true
    }
    
    func disable(){
        self.alpha = 0.8
        self.isUserInteractionEnabled = false
    }
}

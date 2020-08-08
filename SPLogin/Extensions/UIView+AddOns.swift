//
//  UIView+AddOns.swift
//  SPLogin
//
//  Created by Arnaud Barragao on 06/08/2020.
//  Copyright © 2020 abarragao. All rights reserved.
//

import UIKit

extension UIView {
    func addShadow(_ add:Bool = true){
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = self.layer.cornerRadius
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowOpacity = 0.15
        self.layer.masksToBounds = !add
        self.clipsToBounds = false
    }
    
    func shake() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.05
        animation.repeatCount = 3
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 3, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 3, y: self.center.y))
        
        self.layer.add(animation, forKey: "position")
    }
}


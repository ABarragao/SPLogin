//
//  SubView.swift
//  SPLogin
//
//  Created by Arnaud Barragao on 06/08/2020.
//  Copyright © 2020 abarragao. All rights reserved.
//

import UIKit

@IBDesignable
class SubView : SPView{
    
    @IBOutlet weak var title: SPLabel!
    @IBOutlet weak var body: SPLabel!
    
    @IBInspectable var titleColor: Int = Color.white.rawValue{
        didSet{
            self.title.color = self.titleColor
        }
    }
    
    @IBInspectable var bodyColor: Int = Color.white.rawValue{
        didSet{
            self.body.color = self.bodyColor
        }
    }
    
    @IBInspectable var titleText: String = ""{
        didSet{
            self.title?.text = NSLocalizedString(self.titleText, comment: "")
        }
    }
    
}

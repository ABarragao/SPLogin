//
//  ErrorView.swift
//  SPLogin
//
//  Created by Arnaud Barragao on 07/08/2020.
//  Copyright © 2020 abarragao. All rights reserved.
//

import UIKit

@IBDesignable
class ErrorView: SPView {

    @IBOutlet weak var label: SPLabel!
    
    @IBInspectable var text: String = ""{
        didSet{
            self.label?.text = self.text.localized()
        }
    }

}

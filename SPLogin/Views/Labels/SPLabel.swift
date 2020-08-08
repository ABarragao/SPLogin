//
//  SPLabel.swift
//  SPLogin
//
//  Created by Arnaud Barragao on 06/08/2020.
//  Copyright © 2020 abarragao. All rights reserved.
//

import UIKit

@IBDesignable
class SPLabel : UILabel{
    @IBInspectable var type : String = LabelType.body.rawValue{
        didSet{
            switch(self.type){
            case LabelType.title.rawValue:
                self.font = Theme.font.withSize(29)
                break
            case LabelType.subtitle.rawValue:
                self.font = Theme.font.withSize(21)
                break
            default:
                self.font = Theme.font
                break
            }
        }
    }
    
    @IBInspectable var color : Int = Color.white.rawValue{
        didSet{
            switch(self.color){
            case Color.primary.rawValue:
                self.textColor = Theme.primaryColor
                break
            case Color.secondary.rawValue:
                self.textColor = Theme.secondaryColor
                break
            case Color.white.rawValue:
                self.textColor = UIColor.white
                break
            default:
                self.textColor = UIColor.clear
                break
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.text = (self.text ?? "").localized()
    }
}

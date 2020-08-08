//
//  SPView.swift
//  SPLogin
//
//  Created by Arnaud Barragao on 06/08/2020.
//  Copyright © 2020 abarragao. All rights reserved.
//

import UIKit

@IBDesignable
class SPView : UIView{
    var contentView: UIView!
    
    @IBInspectable var backColor : Int = Color.white.rawValue{
        didSet{
            switch(self.backColor){
            case Color.primary.rawValue:
                self.backgroundColor = Theme.primaryColor
                break
            case Color.secondary.rawValue:
                self.backgroundColor = Theme.secondaryColor
                break
            case Color.white.rawValue:
                self.backgroundColor = UIColor.white
            break
            default:
                self.backgroundColor = UIColor.clear
                break
            }
        }
    }
    
    @IBInspectable var shadow : Bool = false{
        didSet{
            self.addShadow(self.shadow)
        }
    }
    
    @IBInspectable var cornerRadius : CGFloat = 0{
        didSet{
            self.layer.cornerRadius = self.cornerRadius
            self.layer.masksToBounds = true
        }
    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpXib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpXib()
    }
    
    func setUpXib(){
        contentView = loadNib()
        contentView.frame = self.bounds
        addSubview(contentView)
    }
    
    func loadNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }
    
}

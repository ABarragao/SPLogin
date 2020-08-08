//
//  FeedbackView.swift
//  SPLogin
//
//  Created by Arnaud Barragao on 06/08/2020.
//  Copyright © 2020 abarragao. All rights reserved.
//

import UIKit


class FeedbackView : SPView{
    
    @IBOutlet weak var starsStackView: UIStackView!
    @IBOutlet weak var subview: SubView!
    
    override func setUpXib(){
        super.setUpXib()
        setUpStars()
    }
    
    func setUpStars(){
        self.starsStackView.arrangedSubviews.forEach { (view) in
            if let imgView = view as? UIImageView{
                imgView.image = imgView.image?.withRenderingMode(.alwaysTemplate)
                imgView.highlightedImage = imgView.highlightedImage?.withRenderingMode(.alwaysTemplate)
                imgView.tintColor = Theme.secondaryColor
            }
        }
    }
    
    func setStars(_ stars : Int){
        var i = 0
        self.starsStackView.arrangedSubviews.forEach { (view) in
            if let imgView = view as? UIImageView{
                imgView.isHighlighted = (i + 1) <= stars
            }
            i += 1
        }
        
        self.subview.body.text = "\(stars)"
    }
    
}

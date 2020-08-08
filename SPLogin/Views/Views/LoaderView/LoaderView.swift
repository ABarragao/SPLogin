//
//  LoaderView.swift
//  SPLogin
//
//  Created by Arnaud Barragao on 08/08/2020.
//  Copyright © 2020 abarragao. All rights reserved.
//

import UIKit

class LoaderView: SPView {

    @IBOutlet weak var loader : UIActivityIndicatorView!
    
    override func setUpXib() {
        super.setUpXib()
        self.loader.color = Theme.secondaryColor
    }

    func startLoading(){
        self.loader.startAnimating()
    }
    
    func stopLoading(){
        self.loader.stopAnimating()
    }
}

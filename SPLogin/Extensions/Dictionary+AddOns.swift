//
//  Dictionary+AddOns.swift
//  SPLogin
//
//  Created by Arnaud Barragao on 02/08/2020.
//  Copyright © 2020 abarragao. All rights reserved.
//

import Foundation

extension Dictionary {
    func getData() -> Data?{
        return try? JSONSerialization.data(withJSONObject: self)
    }
}

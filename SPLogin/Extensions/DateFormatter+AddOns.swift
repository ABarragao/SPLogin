//
//  DateFormatter+AddOns.swift
//  SPLogin
//
//  Created by Arnaud Barragao on 03/08/2020.
//  Copyright © 2020 abarragao. All rights reserved.
//

import Foundation

extension DateFormatter {
  static let apiFormat: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    return formatter
  }()
}

//
//  User.swift
//  SPLogin
//
//  Created by Arnaud Barragao on 03/08/2020.
//  Copyright © 2020 abarragao. All rights reserved.
//

import Foundation

struct User: Codable {
    let email, firstname, lastname, phone: String?
    let shortName: String?
    let id: Int?
    let address: Address?
    let gender: String?
    let birthdayDate: Date?
    let kpi: KPI?

    var completeName: String{
        if let lastName = self.lastname, let firstName = self.firstname {
            return "\(firstName) \(lastName)"
        }
        return "Unknown"
    }
    
    var completeAddress: String{
        if let city = self.address?.city, let country = self.address?.country {
            return "\(city), \(country)"
        }
        return "Unknown"
    }
    
    enum CodingKeys: String, CodingKey {
        case email, firstname, lastname, phone
        case shortName = "short_name"
        case id, address, gender
        case birthdayDate = "birthday_date"
        case kpi
    }
    
    static func decode(_ data: Data?) -> User?{
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(DateFormatter.apiFormat)
                
        guard let data = data else{
            return nil
        }
        return try? decoder.decode(User.self, from: data)
    }
}

// MARK: - Address
struct Address: Codable {
    let street, zipCode, city, country: String?
    let countryCode: String?
    let geoPoint: GeoPoint?

    enum CodingKeys: String, CodingKey {
        case street
        case zipCode = "zip_code"
        case city, country
        case countryCode = "country_code"
        case geoPoint = "geo_point"
    }
    
    var exacteAddress: String?{
        if let street = street, let city = city, let country = country {
            return "\(street) \(city) \(country)"
        }
        return nil
    }
}

// MARK: - GeoPoint
struct GeoPoint: Codable {
    let latitude, longitude: Double?
}

// MARK: - Kpi
struct KPI: Codable {
    let reactivenessPercentage, feedbackAverage, id, countJobsDone: Int?
    let countJobsBackup, countYellowCard: Int?

    enum CodingKeys: String, CodingKey {
        case reactivenessPercentage = "reactiveness_percentage"
        case feedbackAverage = "feedback_average"
        case id
        case countJobsDone = "count_jobs_done"
        case countJobsBackup = "count_jobs_backup"
        case countYellowCard = "count_yellow_card"
    }
}

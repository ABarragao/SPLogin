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
    let admin, customer: Bool?
    let shortName: String?
    let id: Int?
    let address: Address?
    let gender: String?
    let birthdayDate: Date?
    let status: String?
    let hasToSignContract, hasToRenewContract: Bool?
    let state: String?
    let interviewedAtDate: Date?
    let kpi: KPI?
    let hasAssurance: Bool?

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
        case email, firstname, lastname, phone, admin, customer
        case shortName = "short_name"
        case id, address, gender
        case birthdayDate = "birthday_date"
        case status
        case hasToSignContract = "has_to_sign_contract"
        case hasToRenewContract = "has_to_renew_contract"
        case state
        case interviewedAtDate = "interviewed_at_date"
        case kpi
        case hasAssurance = "has_assurance"
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
    let dateFirstJob: Date?

    enum CodingKeys: String, CodingKey {
        case reactivenessPercentage = "reactiveness_percentage"
        case feedbackAverage = "feedback_average"
        case id
        case countJobsDone = "count_jobs_done"
        case countJobsBackup = "count_jobs_backup"
        case countYellowCard = "count_yellow_card"
        case dateFirstJob = "date_first_job"
    }
}

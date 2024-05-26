//
//  RequestModel.swift
//  Staff App
//
//  Created by Tshedza Musandiwa on 2024/05/24.
//

import Foundation

struct LoginRequest: Codable {
    let email: String
    let password: String
}

struct EmployeeDetailsUpdateRequest: Codable {
    let userLoginToken: String
    let personalDetails: PersonalDetails
    let additionalInformation: AdditionalInformation
}

struct PersonalDetails: Codable {
    let id: Int
    let email: String
    let first_name: String
    let last_name: String
    let avatar: String
    let DOB: String
    let gender: String
}


struct AdditionalInformation: Codable {
    let placeOfBirth: String
    let preferredColor: String
    let residentialAddress: String
}

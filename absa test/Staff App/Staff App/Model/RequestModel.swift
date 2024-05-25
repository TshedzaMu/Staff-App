//
//  RequestModel.swift
//  Staff App
//
//  Created by Tshedza Musandiwa on 2024/05/24.
//

import Foundation

struct LoginRequest: Encodable {
    let email: String
    let password: String
}

struct EmployeeDetailsUpdateRequest: Encodable {
    let userLoginToken: String
    let personalDetails: PersonalDetails
    let additionalInformation: AddidtionalInformation
}

struct PersonalDetails: Encodable {
    let id: Int
    let email: String
    let first_name: String
    let last_name: String
    let avatar: String
    let DOB: String
    let gender: String
}


struct AddidtionalInformation: Encodable {
    let placeOfBirth: String
    let preferredColor: String
    let residentialAddress: String
}

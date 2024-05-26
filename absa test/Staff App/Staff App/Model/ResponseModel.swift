//
//  ResponseModel.swift
//  Staff App
//
//  Created by Tshedza Musandiwa on 2024/05/24.
//

import Foundation

struct LoginResponse: Codable {
    let token: String?
}

struct EmployeesResponse: Codable {
    let page: Int?
    let per_page: Int?
    let total: Int?
    let total_pages: Int?
    let data: [Employee]?
    let support: Support?
}

struct Employee: Codable {
    let id: Int?
    let email: String?
    let first_name: String?
    let last_name: String?
    let avatar: String?
}

struct Support: Codable {
    let url: String?
    let text: String?
}

struct ColorsResponse: Codable {
    let page: Int?
    let per_page: Int?
    let total: Int?
    let total_pages: Int?
    let data: [Color]?
    let support: Support?
}

struct Color: Codable {
    let id: Int?
    let name: String?
    let year: Int?
    let color: String?
    let pantone_value: String?
}

struct updateEmployeeResponse: Codable {
    let userLoginToken: String?
    let personalDetails: PersonalDetails?
    let additionalInformation: AdditionalInformation?
    let id: String?
    let createdAt: String?
}



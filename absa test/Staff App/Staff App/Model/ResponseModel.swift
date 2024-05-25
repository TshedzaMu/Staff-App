//
//  ResponseModel.swift
//  Staff App
//
//  Created by Tshedza Musandiwa on 2024/05/24.
//

import Foundation

struct LoginResponse: Decodable {
    let token: String?
}

struct EmployeesResponse: Decodable {
    let page: Int?
    let per_page: Int?
    let total: Int?
    let total_pages: Int?
    let data: [Employee]?
    let support: Support?
}

struct Employee: Decodable {
    let id: Int?
    let email: String?
    let first_name: String?
    let last_name: String?
    let avatar: String?
}

struct Support: Decodable {
    let url: String?
    let text: String?
}

struct ColorsResponse: Decodable {
    let page: Int?
    let per_page: Int?
    let total: Int?
    let total_pages: Int?
    let data: [Color]?
    let support: Support?
}

struct Color: Decodable {
    let id: Int?
    let name: String?
    let year: Int?
    let color: String?
    let pantone_value: String?
}


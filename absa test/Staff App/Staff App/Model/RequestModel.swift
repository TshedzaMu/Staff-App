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
    let email: String
    let password: String
}

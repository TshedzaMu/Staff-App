//
//  EmployeeInformationDataTransporter.swift
//  Staff App
//
//  Created by Tshedza Musandiwa on 2024/05/25.
//

import Foundation

class EmployeeInformationDataTransporter {
    let id: Int?
    let email: String?
    let firstName: String?
    let lastName: String?
    let avatar: String?
    let dateOfBirth: String?
    let gender: String?
    let placeOfBirth: String?
    let preferredColor: String?
    let residentialAddress: String?

    init(id: Int? = nil, email: String? = nil, firstName: String? = nil, lastName: String? = nil, avatar: String? = nil, dateOfBirth: String? = nil, gender: String? = nil, placeOfBirth: String? = nil, preferredColor: String? = nil, residentialAddress: String? = nil) {
        self.id = id
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.avatar = avatar
        self.dateOfBirth = dateOfBirth
        self.gender = gender
        self.placeOfBirth = placeOfBirth
        self.preferredColor = preferredColor
        self.residentialAddress = residentialAddress
    }
}

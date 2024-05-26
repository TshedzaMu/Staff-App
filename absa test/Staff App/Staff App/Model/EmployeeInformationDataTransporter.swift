//
//  EmployeeInformationDataTransporter.swift
//  Staff App
//
//  Created by Tshedza Musandiwa on 2024/05/25.
//

import Foundation

class EmployeeInformationDataTransporter {
    var id: Int?
    var email: String?
    var firstName: String?
    var lastName: String?
    var avatar: String?
    var dateOfBirth: String?
    var gender: String?
    var placeOfBirth: String?
    var preferredColor: String?
    var residentialAddress: String?
    var updateTimeStamp: String?
    var selectedEmployee: Employee?

    init(id: Int? = nil, email: String? = nil, firstName: String? = nil, lastName: String? = nil, avatar: String? = nil, dateOfBirth: String? = nil, gender: String? = nil, placeOfBirth: String? = nil, preferredColor: String? = nil, residentialAddress: String? = nil, updateTimeStamp: String? = nil, selectedEmployee: Employee? = nil) {
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
        self.updateTimeStamp = updateTimeStamp
        self.selectedEmployee = selectedEmployee
    }
    
    var description: String {
        var description = "Employee Information Data Transporter:\n"
        description += "ID: \(id ?? -1)\n"
        description += "Email: \(email ?? "N/A")\n"
        description += "First Name: \(firstName ?? "N/A")\n"
        description += "Last Name: \(lastName ?? "N/A")\n"
        description += "Avatar: \(avatar ?? "N/A")\n"
        description += "Date of Birth: \(dateOfBirth ?? "N/A")\n"
        description += "Gender: \(gender ?? "N/A")\n"
        description += "Place of Birth: \(placeOfBirth ?? "N/A")\n"
        description += "Preferred Color: \(preferredColor ?? "N/A")\n"
        description += "Residential Address: \(residentialAddress ?? "N/A")"
        description += "Time: \(updateTimeStamp ?? "N/A")\n"
        description += "Person: \(selectedEmployee?.first_name ?? "N/A")"
        return description
    }
}

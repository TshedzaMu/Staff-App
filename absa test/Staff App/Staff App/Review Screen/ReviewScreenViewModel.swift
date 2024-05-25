//
//  ReviewScreenViewModel.swift
//  Staff App
//
//  Created by Tshedza Musandiwa on 2024/05/24.
//

import Foundation

class ReviewScreenViewModel {
    
    var dataTransporter: EmployeeInformationDataTransporter
    
    init(dataTransporter: EmployeeInformationDataTransporter) {
        self.dataTransporter = dataTransporter
    }
    
    var imageURL: String {
        return dataTransporter.avatar ?? ""
    }
    

    var employeeFirstName: String {
        return dataTransporter.firstName ?? ""
    }
    
    var employeeLastName: String {
        return dataTransporter.lastName ?? ""
    }
    
    var gender: String {
        return dataTransporter.gender ?? ""
    }
    
    var fullName: String {
        return "\(employeeFirstName ) \(employeeLastName)"
    }
    
    var dateOfBirth: String {
        return dataTransporter.dateOfBirth ?? ""
    }
    
    var email: String {
        return dataTransporter.email ?? ""
    }
    
    var residentialAddress: String {
        return dataTransporter.residentialAddress ?? ""
    }
    
    var placeOfBirth: String {
        return dataTransporter.placeOfBirth ?? ""
    }
    
    var prefferedColor: String {
        return dataTransporter.preferredColor ?? ""
    }
}

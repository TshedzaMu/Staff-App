//
//  AdditionalInfomationViewModel.swift
//  Staff App
//
//  Created by Tshedza Musandiwa on 2024/05/23.
//

import Foundation

class EmployeeInfomationViewModel {
    
    var selectedEmployee: Employee?
    var dataTransporter: EmployeeInformationDataTransporter
    
    init(dataTransporter: EmployeeInformationDataTransporter) {
        self.dataTransporter = dataTransporter
    }
    
    var employeeFirstName: String? {
        return selectedEmployee?.first_name
    }
    
    var employeeLastName: String? {
        return selectedEmployee?.last_name
    }
    
    var fullName: String {
        return "\(employeeFirstName ?? "") \(employeeLastName ?? "")"
    }
    
    var email: String? {
        return selectedEmployee?.email
    }
    
    var imageURL: String {
        return selectedEmployee?.avatar ?? ""
    }
}


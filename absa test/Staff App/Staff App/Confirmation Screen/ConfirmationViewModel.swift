//
//  ConfirmationViewModel.swift
//  Staff App
//
//  Created by Tshedza Musandiwa on 2024/05/24.
//

import Foundation

class ConfirmationViewModel {
    
    var dataTransporter: EmployeeInformationDataTransporter
    
    init(dataTransporter: EmployeeInformationDataTransporter) {
        self.dataTransporter = dataTransporter
    }
    
    var employeeFirstName: String? {
        return dataTransporter.selectedEmployee?.first_name
    }
    
    var employeeLastName: String? {
        return dataTransporter.selectedEmployee?.last_name
    }
    
    var fullName: String {
        return "\(employeeFirstName ?? "") \(employeeLastName ?? "")"
    }
    
    var createdDate: String {
        return dataTransporter.updateTimeStamp ?? ""
    }
    
    
    var message: String {
    return "Congratulations you have successfully updated personal details and additional details for \(fullName) on \(createdDate)"
    }
    
}

//
//  ConfirmationViewModel.swift
//  Staff App
//
//  Created by Tshedza Musandiwa on 2024/05/24.
//

import Foundation

class ConfirmationViewModel {
    
    let dateFormatter = DateFormatter()
    var dataTransporter: EmployeeInformationDataTransporter
    var formattedDate: String?
    var formattedTime: String?
    
    
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
    
    func updateDateFormat() {
        
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"

        if let date = dateFormatter.date(from: createdDate) {
            dateFormatter.dateFormat = "dd MMMM yyyy"
            formattedDate = dateFormatter.string(from: date)
            dateFormatter.dateFormat = "HH:mm"
            formattedTime = dateFormatter.string(from: date)
          
        } else {
            print("Failed to parse date")
        }
    }
    
    var message: String {
        return "Congratulations you have successfully updated personal details and additional details for \(fullName) on \(formattedDate ?? "") at \(formattedTime ?? "")"
    }
    
}

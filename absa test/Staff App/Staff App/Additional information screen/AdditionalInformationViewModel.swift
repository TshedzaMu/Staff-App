//
//  AdditionalInformationViewModel.swift
//  Staff App
//
//  Created by Tshedza Musandiwa on 2024/05/24.
//

import Foundation

enum Gender: String {
    case male = "Male"
    case female = "Female"
    case other = "Other"
}

class AdditionalInformationViewModel {
    
    var dataTransporter: EmployeeInformationDataTransporter
    
    init(dataTransporter: EmployeeInformationDataTransporter) {
        self.dataTransporter = dataTransporter
    }
    
     var selectedColor: Color?
    
    var colorName: String? {
        selectedColor?.name
    }
    
    var color: String? {
        selectedColor?.color
    }
}

//
//  ReviewScreenViewModel.swift
//  Staff App
//
//  Created by Tshedza Musandiwa on 2024/05/24.
//

import Foundation

class ReviewScreenViewModel {
    
    private lazy var service = Service()
    var dataTransporter: EmployeeInformationDataTransporter
    var updateTimeStamp: String?
    
    var onUpdateComplete: (() -> Void)?
    
    init(dataTransporter: EmployeeInformationDataTransporter) {
        self.dataTransporter = dataTransporter
    }
    
    var imageURL: String {
        return dataTransporter.avatar ?? ""
    }
    
    var Id: Int {
        return dataTransporter.id ?? Int()
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
    
    var token: String {
        guard let token = TokenManager.shared.getToken() else { return "" }
        return token
    }
    
    var requestModel: EmployeeDetailsUpdateRequest {
        return EmployeeDetailsUpdateRequest(userLoginToken: token,
                                            personalDetails: PersonalDetails(id: Id,
                                                                             email: email,
                                                                             first_name: employeeFirstName,
                                                                             last_name: employeeLastName,
                                                                             avatar: imageURL,
                                                                             DOB: dateOfBirth,
                                                                             gender: gender),
                                            additionalInformation: AdditionalInformation(placeOfBirth: placeOfBirth,
                                                                                          preferredColor: prefferedColor,
                                                                                          residentialAddress: residentialAddress))
    }
    
    
    func updateDetails() {
        service.updateDetails(body: requestModel) { [weak self] response, error in
             DispatchQueue.main.async {
                 if let error = error {
                     print("Failed to update details: \(error)")
                 } else if let response = response {
                     self?.updateTimeStamp = response.createdAt
                     self?.onUpdateComplete?()
                 }
             }
         }
     }
    
    
}

import Foundation

class ReviewScreenViewModel {
    
    lazy var interactor: StaffInteractorProtocol = StaffInteractor(service: Service())
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
        return dataTransporter.id ?? 0
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
        return "\(employeeFirstName) \(employeeLastName)"
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
    
    var preferredColor: String {
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
                                                                                          preferredColor: preferredColor,
                                                                                          residentialAddress: residentialAddress))
    }
    
    
    func updateDetails() {
        interactor.updateDetails(body: requestModel) { [weak self] result in
            switch result {
            case .success(let response):
                self?.updateTimeStamp = response.createdAt
                self?.onUpdateComplete?()
            case .failure(let error):
                print("Failed to update details: \(error.localizedDescription)")
            }
        }
    }
}

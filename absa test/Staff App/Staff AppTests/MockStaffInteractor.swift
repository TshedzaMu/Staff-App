//
//  MockStaffInteractor.swift
//  Staff AppTests
//
//  Created by Tshedza Musandiwa on 2024/05/28.
//

import Foundation
@testable import Staff_App

// Mock for StaffInteractorProtocol
class MockStaffInteractor: StaffInteractorProtocol {
    var loginResult: Result<LoginResponse, Error>?
    var updateDetailsResult: Result<UpdateEmployeeResponse, Error>?
    var getEmployeesResult: Result<EmployeesResponse, Error>?
    var getColorsResult: Result<ColorsResponse, Error>?
    
    func login(body: LoginRequest, completed: @escaping (Result<LoginResponse, Error>) -> Void) {
        if let result = loginResult {
            completed(result)
        }
    }
    
    func updateDetails(body: EmployeeDetailsUpdateRequest, completed: @escaping (Result<UpdateEmployeeResponse, Error>) -> Void) {
        if let result = updateDetailsResult {
            completed(result)
        }
    }
    
    func getEmployees(completed: @escaping (Result<EmployeesResponse, Error>) -> Void) {
        if let result = getEmployeesResult {
            completed(result)
        }
    }
    
    func getColors(completed: @escaping (Result<ColorsResponse, Error>) -> Void) {
        if let result = getColorsResult {
            completed(result)
        }
    }
}

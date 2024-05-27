//
//  StaffInteractor.swift
//  Staff App
//
//  Created by Tshedza Musandiwa on 2024/05/27.
//

import Foundation

protocol StaffInteractorProtocol {
    func login(body: LoginRequest, completed: @escaping (Result<LoginResponse, Error>) -> Void)
    func updateDetails(body: EmployeeDetailsUpdateRequest, completed: @escaping (Result<UpdateEmployeeResponse, Error>) -> Void)
    func getEmployees(completed: @escaping (Result<EmployeesResponse, Error>) -> Void)
    func getColors(completed: @escaping (Result<ColorsResponse, Error>) -> Void)
}


class StaffInteractor: StaffInteractorProtocol {
    private let service: ServiceProtocol
    
    init(service: ServiceProtocol) {
        self.service = service
    }
    
    func login(body: LoginRequest, completed: @escaping (Result<LoginResponse, Error>) -> Void) {
        let urlString = "https://reqres.in/api/login"
        guard let url = URL(string: urlString) else {
            let error = NSError(domain: "InteractorError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
            completed(.failure(error))
            return
        }
        service.makePostRequest(url: url, body: body, completion: completed)
    }
    
    func updateDetails(body: EmployeeDetailsUpdateRequest, completed: @escaping (Result<UpdateEmployeeResponse, Error>) -> Void) {
        let urlString = "https://reqres.in/api/users"
        guard let url = URL(string: urlString) else {
            let error = NSError(domain: "InteractorError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
            completed(.failure(error))
            return
        }
        service.makePostRequest(url: url, body: body, completion: completed)
    }
    
    func getEmployees(completed: @escaping (Result<EmployeesResponse, Error>) -> Void) {
        let urlString = "https://reqres.in/api/users?page=1&per_page=12"
        guard let url = URL(string: urlString) else {
            let error = NSError(domain: "InteractorError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
            completed(.failure(error))
            return
        }
        service.makeGetRequest(url: url, completion: completed)
    }
    
    func getColors(completed: @escaping (Result<ColorsResponse, Error>) -> Void) {
        let urlString = "https://reqres.in/api/unknown?per_page=12"
        guard let url = URL(string: urlString) else {
            let error = NSError(domain: "InteractorError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
            completed(.failure(error))
            return
        }
        service.makeGetRequest(url: url, completion: completed)
    }
}



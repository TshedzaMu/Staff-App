//
//  EmployessListViewModel.swift
//  Staff App
//
//  Created by Tshedza Musandiwa on 2024/05/23.
//

import Foundation

protocol EmployeeSelectionDelegate: AnyObject {
    func didSelectEmployee(_ employee: Employee)
}

class EmployessListViewModel {
    
    var numberOfEmployees: Int?
    var employeeList: [Employee]?
    
    private lazy var service = Service()
    
    var onEmployeesFetched: (() -> Void)?
    
    func getEmployeeList()  {
        service.getEmployees { [weak self] response, error in
            if let response = response {
                print("Total employees: \(response.total ?? 0)")
                if let employees = response.data,
                   let numberOfEmployees = response.total {
                    self?.employeeList = employees
                    self?.numberOfEmployees = numberOfEmployees
                    self?.onEmployeesFetched?()
                }
            } else {
                print("Failed to fetch employees, error: \(error ?? "Unknown error")")
            }
        }
    }
}

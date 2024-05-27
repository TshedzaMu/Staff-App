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
    
    var employeeList: [Employee]?
    var unFiltredEmployeeList: [Employee] = []
    
    private lazy var service = Service()
    
    var onEmployeesFetched: (() -> Void)?
    var onFetchFailed: ((String) -> Void)?
    
    var employeeListNumber: Int {
        return employeeList?.count ?? 0
    }
    
    func getEmployeeList() {
        service.getEmployees { [weak self] response, error in
            if let employees = response?.data {
                self?.employeeList = employees
                self?.unFiltredEmployeeList = employees
                self?.onEmployeesFetched?()
            } else {
                let errorMessage = error ?? "Unknown error"
                print("Failed to fetch employees, error: \(errorMessage)")
                self?.onFetchFailed?(errorMessage)
            }
        }
    }
    
    func filterEmployeeList(with text: String) {
        if text.isEmpty {
            employeeList = unFiltredEmployeeList
        } else {
            employeeList = employeeList?.filter { $0.first_name?.localizedCaseInsensitiveContains(text) ?? false }
        }
    }
}

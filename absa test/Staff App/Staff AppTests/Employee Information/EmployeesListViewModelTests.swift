//
//  EmployeesListViewModelTests.swift
//  Staff AppTests
//
//  Created by Tshedza Musandiwa on 2024/05/28.
//

import XCTest
@testable import Staff_App

final class EmployeesListViewModelTests: XCTestCase {
    
    var viewModel: EmployessListViewModel!
    var mockInteractor: MockStaffInteractor!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        mockInteractor = MockStaffInteractor()
        viewModel = EmployessListViewModel()
        viewModel.interactor = mockInteractor
    }

    override func tearDownWithError() throws {
        viewModel = nil
        mockInteractor = nil
        try super.tearDownWithError()
    }
    
    func testGetEmployeeListSuccess() {
        let employees = [Employee(id: 1, email: "test1@example.com", first_name: "John", last_name: "Doe", avatar: nil),
                         Employee(id: 2, email: "test2@example.com", first_name: "Jane", last_name: "Doe", avatar: nil)]
       // mockInteractor.getEmployeesResult = .success(EmployeesResponse(data: employees as? [Employee] as! Decoder))

        let expectation = self.expectation(description: "Employees fetched successfully")
        
        viewModel.onEmployeesFetched = {
            XCTAssertEqual(self.viewModel.employeeList?.count, employees.count)
            XCTAssertEqual(self.viewModel.employeeList?[0].first_name, "John")
            XCTAssertEqual(self.viewModel.employeeList?[1].first_name, "Jane")
            expectation.fulfill()
        }
        
        viewModel.getEmployeeList()
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testGetEmployeeListFailure() {
        let error = NSError(domain: "test", code: 1, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch employees"])
        mockInteractor.getEmployeesResult = .failure(error)
        
        let expectation = self.expectation(description: "Fetch employees failed")
        
        viewModel.onFetchFailed = { errorMessage in
            XCTAssertEqual(errorMessage, "Failed to fetch employees")
            expectation.fulfill()
        }
        
        viewModel.getEmployeeList()
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testFilterEmployeeListEmptyText() {
        let employees = [Employee(id: 1, email: "test1@example.com", first_name: "John", last_name: "Doe", avatar: nil),
                         Employee(id: 2, email: "test2@example.com", first_name: "Jane", last_name: "Doe", avatar: nil)]
        viewModel.unFilteredEmployeeList = employees
        
        viewModel.filterEmployeeList(with: "")
        
        XCTAssertEqual(viewModel.employeeList?.count, employees.count)
        XCTAssertEqual(viewModel.employeeList?[0].first_name, "John")
        XCTAssertEqual(viewModel.employeeList?[1].first_name, "Jane")
    }
    
    func testFilterEmployeeListWithText() {
        let employees = [Employee(id: 1, email: "test1@example.com", first_name: "John", last_name: "Doe", avatar: nil),
                         Employee(id: 2, email: "test2@example.com", first_name: "Jane", last_name: "Doe", avatar: nil)]
        viewModel.unFilteredEmployeeList = employees
        
        viewModel.filterEmployeeList(with: "John")
        
        XCTAssertEqual(viewModel.employeeList?.count, 1)
        XCTAssertEqual(viewModel.employeeList?[0].first_name, "John")
    }
    
    func testFilterEmployeeListNoMatch() {
        let employees = [Employee(id: 1, email: "test1@example.com", first_name: "John", last_name: "Doe", avatar: nil),
                         Employee(id: 2, email: "test2@example.com", first_name: "Jane", last_name: "Doe", avatar: nil)]
        viewModel.unFilteredEmployeeList = employees
        
        viewModel.filterEmployeeList(with: "Alice")
        
        XCTAssertEqual(viewModel.employeeList?.count, 0)
    }
}

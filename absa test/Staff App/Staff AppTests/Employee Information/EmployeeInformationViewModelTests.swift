//
//  EmployeeInformationViewModelTests.swift
//  Staff AppTests
//
//  Created by Tshedza Musandiwa on 2024/05/28.
//

import XCTest
@testable import Staff_App

final class EmployeeInformationViewModelTests: XCTestCase {
    
    var viewModel: EmployeeInfomationViewModel!
    var dataTransporter: EmployeeInformationDataTransporter!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        dataTransporter = EmployeeInformationDataTransporter()
        viewModel = EmployeeInfomationViewModel(dataTransporter: dataTransporter)
    }

    override func tearDownWithError() throws {
        viewModel = nil
        dataTransporter = nil
        try super.tearDownWithError()
    }
    
    func testEmployeeFirstName() {
        let employee = Employee(id: 1, email: "test@example.com", first_name: "John", last_name: "Doe", avatar: "http://example.com/avatar.png")
        viewModel.selectedEmployee = employee
        XCTAssertEqual(viewModel.employeeFirstName, "John")
    }
    
    func testEmployeeLastName() {
        let employee = Employee(id: 1, email: "test@example.com", first_name: "John", last_name: "Doe", avatar: "http://example.com/avatar.png")
        viewModel.selectedEmployee = employee
        XCTAssertEqual(viewModel.employeeLastName, "Doe")
    }
    
    func testFullName() {
        let employee = Employee(id: 1, email: "test@example.com", first_name: "John", last_name: "Doe", avatar: "http://example.com/avatar.png")
        viewModel.selectedEmployee = employee
        XCTAssertEqual(viewModel.fullName, "John Doe")
    }
    
    func testFullNameWhenFirstNameIsNil() {
        let employee = Employee(id: 1, email: "test@example.com", first_name: nil, last_name: "Doe", avatar: "http://example.com/avatar.png")
        viewModel.selectedEmployee = employee
        XCTAssertEqual(viewModel.fullName, " Doe")
    }
    
    func testFullNameWhenLastNameIsNil() {
        let employee = Employee(id: 1, email: "test@example.com", first_name: "John", last_name: nil, avatar: "http://example.com/avatar.png")
        viewModel.selectedEmployee = employee
        XCTAssertEqual(viewModel.fullName, "John ")
    }
    
    func testFullNameWhenFirstAndLastNameAreNil() {
        let employee = Employee(id: 1, email: "test@example.com", first_name: nil, last_name: nil, avatar: "http://example.com/avatar.png")
        viewModel.selectedEmployee = employee
        XCTAssertEqual(viewModel.fullName, " ")
    }
    
    func testEmail() {
        let employee = Employee(id: 1, email: "test@example.com", first_name: "John", last_name: "Doe", avatar: "http://example.com/avatar.png")
        viewModel.selectedEmployee = employee
        XCTAssertEqual(viewModel.email, "test@example.com")
    }
    
    func testImageURL() {
        let employee = Employee(id: 1, email: "test@example.com", first_name: "John", last_name: "Doe", avatar: "http://example.com/avatar.png")
        viewModel.selectedEmployee = employee
        XCTAssertEqual(viewModel.imageURL, "http://example.com/avatar.png")
    }
    
    func testImageURLWhenAvatarIsNil() {
        let employee = Employee(id: 1, email: "test@example.com", first_name: "John", last_name: "Doe", avatar: nil)
        viewModel.selectedEmployee = employee
        XCTAssertEqual(viewModel.imageURL, "")
    }
}

//
//  ConfirmationViewModelTests.swift
//  Staff AppTests
//
//  Created by Tshedza Musandiwa on 2024/05/28.
//

import XCTest
@testable import Staff_App

final class ConfirmationViewModelTests: XCTestCase {
    
    var viewModel: ConfirmationViewModel!
    var mockDataTransporter: EmployeeInformationDataTransporter!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        let dateString = "2024-05-28T12:00:00Z"
        mockDataTransporter = EmployeeInformationDataTransporter(id: 1, email: "test@example.com", firstName: "John", lastName: "Doe", avatar: "avatar_url", dateOfBirth: "01-01-1990", gender: "Male", placeOfBirth: "New York", preferredColor: "Blue", residentialAddress: "123 Main St", updateTimeStamp: dateString, selectedEmployee: Employee(id: 1, email: "test@example.com", first_name: "John", last_name: "Doe", avatar: "avatar_url"))
        viewModel = ConfirmationViewModel(dataTransporter: mockDataTransporter)
    }

    override func tearDownWithError() throws {
        viewModel = nil
        mockDataTransporter = nil
        try super.tearDownWithError()
    }
    
    func testEmployeeFirstName() {
        XCTAssertEqual(viewModel.employeeFirstName, "John")
    }
    
    func testEmployeeLastName() {
        XCTAssertEqual(viewModel.employeeLastName, "Doe")
    }
    
    func testFullName() {
        XCTAssertEqual(viewModel.fullName, "John Doe")
    }
    
    func testCreatedDate() {
        XCTAssertEqual(viewModel.createdDate, "2024-05-28T12:00:00Z")
    }
}


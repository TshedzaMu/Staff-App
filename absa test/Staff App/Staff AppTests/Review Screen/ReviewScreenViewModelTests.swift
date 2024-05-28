//
//  ReviewScreenViewModelTests.swift
//  Staff AppTests
//
//  Created by Tshedza Musandiwa on 2024/05/28.
//

import XCTest
@testable import Staff_App

final class ReviewScreenViewModelTests: XCTestCase {
    
    var viewModel: ReviewScreenViewModel!
    var mockInteractor: MockStaffInteractor!
    var mockDataTransporter: EmployeeInformationDataTransporter!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        mockInteractor = MockStaffInteractor()
        mockDataTransporter = EmployeeInformationDataTransporter(id: 1, email: "test@example.com", firstName: "John", lastName: "Doe", avatar: "avatar_url", dateOfBirth: "01-01-1990", gender: "Male", placeOfBirth: "New York", preferredColor: "Blue", residentialAddress: "123 Main St", updateTimeStamp: nil, selectedEmployee: nil)
        viewModel = ReviewScreenViewModel(dataTransporter: mockDataTransporter)
        viewModel.interactor = mockInteractor
    }

    override func tearDownWithError() throws {
        viewModel = nil
        mockInteractor = nil
        mockDataTransporter = nil
        try super.tearDownWithError()
    }
    
    func testImageURL() {
        XCTAssertEqual(viewModel.imageURL, "avatar_url")
    }
    
    func testId() {
        XCTAssertEqual(viewModel.Id, 1)
    }
    
    func testEmployeeFirstName() {
        XCTAssertEqual(viewModel.employeeFirstName, "John")
    }
    
    func testEmployeeLastName() {
        XCTAssertEqual(viewModel.employeeLastName, "Doe")
    }
    
    func testGender() {
        XCTAssertEqual(viewModel.gender, "Male")
    }
    
    func testFullName() {
        XCTAssertEqual(viewModel.fullName, "John Doe")
    }
    
    func testDateOfBirth() {
        XCTAssertEqual(viewModel.dateOfBirth, "01-01-1990")
    }
    
    func testEmail() {
        XCTAssertEqual(viewModel.email, "test@example.com")
    }
    
    func testResidentialAddress() {
        XCTAssertEqual(viewModel.residentialAddress, "123 Main St")
    }
    
    func testPlaceOfBirth() {
        XCTAssertEqual(viewModel.placeOfBirth, "New York")
    }
    
    func testPreferredColor() {
        XCTAssertEqual(viewModel.preferredColor, "Blue")
    }
    
    func testToken() {
        XCTAssertEqual(viewModel.token, TokenManager.shared.getToken())
    }
    
    func testRequestModel() {
        let requestModel = viewModel.requestModel
        XCTAssertEqual(requestModel.userLoginToken, TokenManager.shared.getToken())
        XCTAssertEqual(requestModel.personalDetails.id, 1)
        XCTAssertEqual(requestModel.personalDetails.email, "test@example.com")
        XCTAssertEqual(requestModel.personalDetails.first_name, "John")
        XCTAssertEqual(requestModel.personalDetails.last_name, "Doe")
        XCTAssertEqual(requestModel.personalDetails.avatar, "avatar_url")
        XCTAssertEqual(requestModel.personalDetails.DOB, "01-01-1990")
        XCTAssertEqual(requestModel.personalDetails.gender, "Male")
        XCTAssertEqual(requestModel.additionalInformation.placeOfBirth, "New York")
        XCTAssertEqual(requestModel.additionalInformation.preferredColor, "Blue")
        XCTAssertEqual(requestModel.additionalInformation.residentialAddress, "123 Main St")
    }
    
    func testUpdateDetailsSuccess() {
        let expectation = self.expectation(description: "Details updated successfully")
        viewModel.onUpdateComplete = {
            XCTAssertEqual(self.viewModel.updateTimeStamp, "2024-05-28T12:00:00Z")
            expectation.fulfill()
        }
        
        viewModel.updateDetails()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 2, handler: nil)
    }

    
    func testUpdateDetailsFailure() {
        let error = NSError(domain: "test", code: 1, userInfo: [NSLocalizedDescriptionKey: "Failed to update details"])
        mockInteractor.updateDetailsResult = .failure(error)
        
        let expectation = self.expectation(description: "Update details failed")
        
        viewModel.updateDetails()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            // Wait a bit to ensure the error callback is called
            XCTAssertNil(self.viewModel.updateTimeStamp)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
}


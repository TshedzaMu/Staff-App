//
//  LoginViewModelTests.swift
//  Staff AppTests
//
//  Created by Tshedza Musandiwa on 2024/05/28.
//

import XCTest
@testable import Staff_App

final class LoginViewModelTests: XCTestCase {

    var viewModel: LoginViewModel!
    var mockInteractor: MockStaffInteractor!
    var mockDelegate: MockLoginViewModelDelegate!

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockInteractor = MockStaffInteractor()
        mockDelegate = MockLoginViewModelDelegate()
        viewModel = LoginViewModel(interactor: mockInteractor)
        viewModel.delegate = mockDelegate
    }

    override func tearDownWithError() throws {
        viewModel = nil
        mockInteractor = nil
        mockDelegate = nil
        try super.tearDownWithError()
    }

    func testLoginSuccess() throws {
        let response = LoginResponse(token: "validToken")
        mockInteractor.loginResult = .success(response)
        
        viewModel.login(email: "test@example.com", password: "password123")
        
        XCTAssertTrue(mockDelegate.didLoginSuccessfullyCalled)
        XCTAssertFalse(mockDelegate.didFailToLoginCalled)
    }
    
    func testLoginFailureInvalidToken() throws {
        let response = LoginResponse(token: nil)
        mockInteractor.loginResult = .success(response)
        
        viewModel.login(email: "test@example.com", password: "password123")
        
        XCTAssertFalse(mockDelegate.didLoginSuccessfullyCalled)
        XCTAssertTrue(mockDelegate.didFailToLoginCalled)
        XCTAssertEqual(mockDelegate.error, "Invalid token")
    }
    
    func testLoginFailureWithError() throws {
        let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Network error"])
        mockInteractor.loginResult = .failure(error)
        
        viewModel.login(email: "test@example.com", password: "password123")
        
        XCTAssertFalse(mockDelegate.didLoginSuccessfullyCalled)
        XCTAssertTrue(mockDelegate.didFailToLoginCalled)
        XCTAssertEqual(mockDelegate.error, "Network error")
    }
}

class MockLoginViewModelDelegate: LoginViewModelDelegate {
    var didLoginSuccessfullyCalled = false
    var didFailToLoginCalled = false
    var error: String?

    func didLoginSuccessfully() {
        didLoginSuccessfullyCalled = true
    }
    
    func didFailToLogin(withError error: String) {
        didFailToLoginCalled = true
        self.error = error
    }
}

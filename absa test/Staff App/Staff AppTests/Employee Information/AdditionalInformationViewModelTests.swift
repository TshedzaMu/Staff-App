//
//  AdditionalInformationViewModelTests.swift
//  Staff AppTests
//
//  Created by Tshedza Musandiwa on 2024/05/28.
//

import XCTest
@testable import Staff_App

final class AdditionalInformationViewModelTests: XCTestCase {
    
    var viewModel: AdditionalInformationViewModel!
    var dataTransporter: EmployeeInformationDataTransporter!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        dataTransporter = EmployeeInformationDataTransporter()
        viewModel = AdditionalInformationViewModel(dataTransporter: dataTransporter)
    }

    override func tearDownWithError() throws {
        viewModel = nil
        dataTransporter = nil
        try super.tearDownWithError()
    }
    
    func testColorNameNil() {
        XCTAssertNil(viewModel.colorName)
    }
    
    func testColorNil() {
        XCTAssertNil(viewModel.color)
    }
    
    func testColorName() {
        let color = Color(id: 1, name: "Red", year: 1, color: "#FF0000", pantone_value: "")
        viewModel.selectedColor = color
        
        XCTAssertEqual(viewModel.colorName, "Red")
    }
    
    func testColor() {
        let color = Color(id: 1, name: "Red", year: 1, color: "#FF0000", pantone_value: "")
        viewModel.selectedColor = color
        
        XCTAssertEqual(viewModel.color, "#FF0000")
    }
}


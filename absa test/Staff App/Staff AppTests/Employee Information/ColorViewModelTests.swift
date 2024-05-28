//
//  ColorViewModelTests.swift
//  Staff AppTests
//
//  Created by Tshedza Musandiwa on 2024/05/28.
//

import XCTest
@testable import Staff_App

final class ColorViewModelTests: XCTestCase {
    
    var viewModel: ColorViewModel!
    var mockInteractor: MockStaffInteractor!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        mockInteractor = MockStaffInteractor()
        viewModel = ColorViewModel()
        viewModel.interactor = mockInteractor
    }

    override func tearDownWithError() throws {
        viewModel = nil
        mockInteractor = nil
        try super.tearDownWithError()
    }
    
    func testGetColorsSuccess() {
        let colors = [Color(id: 1, name: "Red", year: 2022, color: "#FF0000", pantone_value: "12345"),
                      Color(id: 2, name: "Blue", year: 2022, color: "#0000FF", pantone_value: "67890")]
        let response = ColorsResponse(page: nil, per_page: nil, total: nil, total_pages: nil, data: colors, support: nil)
        mockInteractor.getColorsResult = .success(response)

        
        let expectation = self.expectation(description: "Colors fetched successfully")
        
        viewModel.onColorsFetched = {
            XCTAssertEqual(self.viewModel.numberOfColors, colors.count)
            expectation.fulfill()
        }
        
        viewModel.getColors()
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testGetColorsFailure() {
        let error = NSError(domain: "test", code: 1, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch colors"])
        mockInteractor.getColorsResult = .failure(error)
        
        let expectation = self.expectation(description: "Fetch colors failed")
        
        viewModel.onFetchFailed = { errorMessage in
            XCTAssertEqual(errorMessage, "Failed to fetch colors")
            expectation.fulfill()
        }
        
        viewModel.getColors()
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testNumberOfColors() {
        let colors = [Color(id: 1, name: "Red", year: 2022, color: "#FF0000", pantone_value: "12345"),
                      Color(id: 2, name: "Blue", year: 2022, color: "#0000FF", pantone_value: "67890")]
        viewModel.colorList = colors
        
        XCTAssertEqual(viewModel.numberOfColors, colors.count)
    }
}


//
//  HomeViewModelTests.swift
//  WorkoutBuddyMobileiOSTests
//
//  Created by Aldea Alexia on 25.01.2024.
//

import XCTest
@testable import WorkoutBuddyMobileiOS

class HomeViewModelTests: XCTestCase {
    
    var viewModel: HomeViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = HomeViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testLogoutSuccess() {
        let expectation = self.expectation(description: "Logout successful")
        
        viewModel.eventSubject.sink { completion in
            switch completion {
            case .logout:
                XCTAssertTrue(true)
                expectation.fulfill()
            case .failure:
                XCTFail("Logout should succeed")
            }
        }.store(in: &viewModel.bag)
        
        viewModel.logOut()
        waitForExpectations(timeout: 5, handler: nil)
    }
}

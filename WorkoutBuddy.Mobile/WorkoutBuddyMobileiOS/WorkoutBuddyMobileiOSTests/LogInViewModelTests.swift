//
//  LogInViewModelTests.swift
//  WorkoutBuddyMobileiOSTests
//
//  Created by Aldea Alexia on 25.01.2024.
//

import XCTest
@testable import WorkoutBuddyMobileiOS

class LoginViewModelTests: XCTestCase {
    
    var viewModel: LoginViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = LoginViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testLoginSuccess() {
        let expectation = self.expectation(description: "Login successful")
        
        viewModel.loginCompletion.sink { completion in
            switch completion {
            case .login:
                XCTAssertTrue(true)
                expectation.fulfill()
            case .failure:
                XCTFail("Login should succeed")
            }
        }.store(in: &viewModel.bag)
        
        viewModel.login()
        
        waitForExpectations(timeout: 5, handler: nil)
    }
}


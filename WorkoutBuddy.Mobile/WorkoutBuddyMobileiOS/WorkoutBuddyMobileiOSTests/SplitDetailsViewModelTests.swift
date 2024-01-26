//
//  SplitDetailsViewModelTests.swift
//  WorkoutBuddyMobileiOSTests
//
//  Created by Aldea Alexia on 25.01.2024.
//

import XCTest
import Combine
@testable import WorkoutBuddyMobileiOS

class SplitDetailsViewModelTests: XCTestCase {
    
    var viewModel: SplitDetailsViewModel!
    var bag = Set<AnyCancellable>()
    
    override func setUp() {
        super.setUp()
        viewModel = SplitDetailsViewModel(splitId: "testSplitId")
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testSplitDetailsLoadingState() {
        let expectation = self.expectation(description: "Loading state")
        
        viewModel.$splitDetailsState.sink { state in
            switch state {
            case .loading:
                expectation.fulfill()
            default:
                break
            }
        }.store(in: &bag)
        
        waitForExpectations(timeout: 5, handler: nil)
    }
}

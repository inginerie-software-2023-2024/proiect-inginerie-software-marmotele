//
//  SplitHistoryViewModelTests.swift
//  WorkoutBuddyMobileiOSTests
//
//  Created by Aldea Alexia on 25.01.2024.
//

import XCTest
import Combine
@testable import WorkoutBuddyMobileiOS

class SplitHistoryViewModelTests: XCTestCase {
    
    var viewModel: SplitHistoryViewModel!
    var bag = Set<AnyCancellable>()
    
    override func setUp() {
        super.setUp()
        viewModel = SplitHistoryViewModel(workout: Workout(workoutName: "testWorkoutName", 
                                                           workoutId: "testWorkoutId"))
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testSplitHistoryLoadingState() {
        let expectation = self.expectation(description: "Loading state")
        
        viewModel.$seeHistoryState.sink { state in
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

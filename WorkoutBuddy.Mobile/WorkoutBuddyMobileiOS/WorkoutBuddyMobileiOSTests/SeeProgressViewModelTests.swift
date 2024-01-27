//
//  SeeProgressViewModelTests.swift
//  WorkoutBuddyMobileiOSTests
//
//  Created by Aldea Alexia on 25.01.2024.
//

import XCTest
import Combine
@testable import WorkoutBuddyMobileiOS

class SeeProgressViewModelTests: XCTestCase {
    
    var viewModel: SeeProgressViewModel!
    var bag = Set<AnyCancellable>()
    
    override func setUp() {
        super.setUp()
        viewModel = SeeProgressViewModel(workout: Workout(workoutName: "testWorkoutName",
                                                          workoutId: "testWorkoutId"),
                                         splitId: "testSplitId",
                                         userId: "testUserId")
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testSeeProgressLoadingState() {
        let expectation = self.expectation(description: "Loading state")
        
        viewModel.$seeProgressState.sink { state in
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


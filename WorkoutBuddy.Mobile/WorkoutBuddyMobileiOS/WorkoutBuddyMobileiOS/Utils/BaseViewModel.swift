//
//  BaseViewModel.swift
//  WorkoutBuddyMobileiOS
//
//  Created by Aldea Alexia on 20.10.2023.
//

import Foundation
import Combine

class BaseViewModel: ObservableObject {
    var bag = Set<AnyCancellable>()
}

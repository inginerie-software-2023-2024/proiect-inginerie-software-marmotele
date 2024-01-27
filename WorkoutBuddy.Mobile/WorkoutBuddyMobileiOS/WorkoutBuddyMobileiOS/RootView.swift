//
//  WorkoutBuddyMobileiOSApp.swift
//  WorkoutBuddyMobileiOS
//
//  Created by Aldea Alexia on 20.10.2023.
//

import SwiftUI

struct RootView: View {
    
    @ObservedObject var navigation: Navigation
    
    var body: some View {
        ZStack(alignment: .bottom) {
            NavigationHostView(navigation: navigation)
        }.ignoresSafeArea()
    }
    
}

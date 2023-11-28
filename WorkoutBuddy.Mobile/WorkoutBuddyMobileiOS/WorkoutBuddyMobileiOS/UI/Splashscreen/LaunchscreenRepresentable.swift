//
//  LaunchscreenRepresentable.swift
//  WorkoutBuddyMobileiOS
//
//  Created by Aldea Alexia on 28.11.2023.
//

import Foundation

import SwiftUI

struct LaunchscreenRepresentable: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> UIViewController {
        UIStoryboard(name: "LaunchScreen", bundle: .main).instantiateInitialViewController()!
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {

    }
}

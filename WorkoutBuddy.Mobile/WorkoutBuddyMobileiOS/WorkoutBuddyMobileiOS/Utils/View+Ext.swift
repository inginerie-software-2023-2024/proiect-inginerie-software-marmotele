//
//  View+Ext.swift
//  WorkoutBuddyMobileiOS
//
//  Created by Aldea Alexia on 28.11.2023.
//

import Foundation
import SwiftUI

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}

//
//  View+Extensions.swift
//  SignUp
//
//  Created by Veronica Gliga on 23.10.2024.
//

import SwiftUI

/// Custom SwiftUI View Extensions
extension View {
    /// Disable With Opacity
    @ViewBuilder
    func disableWithOpacity(_ condition: Bool) -> some View {
        self
            .disabled(condition)
            .opacity(condition ? 0.5 : 1)
    }
}

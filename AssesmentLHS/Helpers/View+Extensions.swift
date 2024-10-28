//
//  View+Extensions.swift
//  AssesmentLHS
//
//  Created by Veronica Gliga on 23.10.2024.
//

import SwiftUI

struct DismissKeyboardOnTap: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(Color.clear) // Ensures it doesn’t override existing background
            .onTapGesture {
                hideKeyboard()
            }
    }
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

/// Custom SwiftUI View Extensions
extension View {
    /// Disable With Opacity
    @ViewBuilder
    func disableWithOpacity(_ condition: Bool) -> some View {
        self
            .disabled(condition)
            .opacity(condition ? 0.5 : 1)
    }
    
    func dismissKeyboardOnTap() -> some View {
        self.modifier(DismissKeyboardOnTap())
    }
}

//
//  ContentView.swift
//  AssesmentLHS
//
//  Created by Veronica Gliga on 26.10.2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var container = DependencyContainer()
    
    var body: some View {
        Group {
            if container.coordinator.currentView == .confirmation {
                if let user = container.userManager.fetchUser() {
                    ConfirmationView(viewModel: ConfirmationViewModel(userManager: container.userManager,
                                                                      coordinator: container.coordinator,
                                                                      user: user))
                }
            } else {
                    SignUpView(viewModel: SignUpViewModel(pilotLicenseManager: container.pilotLicenseManager,
                                                          userManager: container.userManager, coordinator: container.coordinator))
                
            }
        }
        .animation(.easeInOut, value: container.coordinator.currentView)
    }
}

#Preview {
    ContentView()
}

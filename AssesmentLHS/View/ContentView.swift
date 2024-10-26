//
//  ContentView.swift
//  AssesmentLHS
//
//  Created by Veronica Gliga on 26.10.2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var coordinator = AppCoordinator()
    
    var body: some View {
        Group {
            if coordinator.currentView == .signUp {
                SignUpView(coordinator: coordinator, viewModel: SignUpViewModel(dataManager: DataManager()))
            } else {
                ConfirmationView(coordinator: coordinator, viewModel: ConfirmationViewModel(userName: "John Doe", pilotLicense: PilotLicense(type: "ATPL", aircrafts: ["B737", "A380", "B747"])))
            }
        }
        .animation(.easeInOut, value: coordinator.currentView)
    }
}

#Preview {
    ContentView()
}

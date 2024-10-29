//
//  SignUpCoordinator.swift
//  AssesmentLHS
//
//  Created by Veronica Gliga on 26.10.2024.
//

import Foundation

// Enum to manage the type of view for navigation
enum ViewType {
    case signUp
    case confirmation
}

// Coordinator for managing navigation
class AppCoordinator: ObservableObject {
    // This property determines which view is currently displayed
    @Published var currentView: ViewType
    private var userManager: UserManagerProtocol
    
    init(userManager: UserManagerProtocol) {
        self.userManager = userManager
        // Set initial view based on user existence
        self.currentView = userManager.userExists() ? .confirmation : .signUp
    }

    // Method to navigate to ConfirmationView
    func navigateToConfirmation() {
        currentView = .confirmation
    }
    
    // Method to log out and return to the sign-up page
    func logout() {
        currentView = .signUp
    }
}

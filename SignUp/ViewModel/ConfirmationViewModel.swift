//
//  ConfirmationViewModel.swift
//  SignUp
//
//  Created by Veronica Gliga on 26.10.2024.
//

import Foundation

@MainActor
class ConfirmationViewModel: ObservableObject {
    // MARK: - Properties
    
    var userManager: UserManagerProtocol
    
    @Published var coordinator: AppCoordinator
    @Published var currentUser: User
    
    // MARK: - Init
    
    init(userManager: UserManagerProtocol, coordinator: AppCoordinator, user: User) {
        self.userManager = userManager
        self.coordinator = coordinator
        self.currentUser = user
    }
    
    // MARK: - Functions
    
    func logout() {
        userManager.deleteUser()
        coordinator.logout()
    }
}

//
//  ConfirmationViewModel.swift
//  AssesmentLHS
//
//  Created by Veronica Gliga on 26.10.2024.
//

import Foundation

@MainActor
class ConfirmationViewModel: ObservableObject {
    var userManager: UserManager
    @Published var coordinator: AppCoordinator
    
    @Published var currentUser: User
    
    init(userManager: UserManager, coordinator: AppCoordinator, user: User) {
        self.userManager = userManager
        self.coordinator = coordinator
        self.currentUser = user
    }
    
    func logout() {
        userManager.deleteUser()
        coordinator.logout()
    }
}

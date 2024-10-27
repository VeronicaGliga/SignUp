//
//  DependencyContainer.swift
//  AssesmentLHS
//
//  Created by Veronica Gliga on 26.10.2024.
//

import Foundation
import Combine

class DependencyContainer: ObservableObject {
    // MARK: - Properties
    @Published var coordinator: AppCoordinator
    
    let pilotLicenseManager: PilotLicenseManager
    var userManager: UserManager
    
    var anyCancellable: AnyCancellable? = nil

    // MARK: - Init
    
    init() {
        let fileStorage = FileStorage<Pilot>()
        self.pilotLicenseManager = PilotLicenseManager(dataManager: fileStorage)
        
        let userDefaultsStorage = UserDefaultsStorage<User>()
        self.userManager = UserManager(dataManager: userDefaultsStorage)
        
        self.coordinator = AppCoordinator(userManager: userManager)
        
        anyCancellable = coordinator.objectWillChange.sink { [weak self] _ in
            print("DependencyContainer's coordinator property has changed.")
            self?.objectWillChange.send()
        }
    }
}

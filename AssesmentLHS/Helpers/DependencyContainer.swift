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
    
    let pilotLicenseManager: PilotLicenseProtocol
    var userManager: UserManagerProtocol
    
    var anyCancellable: AnyCancellable? = nil

    // MARK: - Init
    
    init() {
        let fileStorage = FileStorage<Pilot>()
        let anyFileHandler = AnyDataFetcher(fileStorage)
        self.pilotLicenseManager = PilotLicenseManager(dataManager: anyFileHandler)
        
        let userDefaultsStorage = UserDefaultsStorage<User>()
        let anyDataHandler = AnyDataHandler(userDefaultsStorage)
        self.userManager = UserManager(dataManager: anyDataHandler)
        
        self.coordinator = AppCoordinator(userManager: userManager)
        
        anyCancellable = coordinator.objectWillChange.sink { [weak self] _ in
            print("DependencyContainer's coordinator property has changed.")
            self?.objectWillChange.send()
        }
    }
}

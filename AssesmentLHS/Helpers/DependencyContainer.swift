//
//  DependencyContainer.swift
//  AssesmentLHS
//
//  Created by Veronica Gliga on 26.10.2024.
//

import Foundation
import Combine

class DependencyContainer: ObservableObject {
    @Published var coordinator: AppCoordinator
    
    let pilotLicenseManager: PilotLicenseManager
    var userManager: UserManager
    
    var anyCancellable: AnyCancellable? = nil

    init() {
        
        let fileStorage = FileStorage<Pilot>()
        let dataManager = DataManager(storage: fileStorage)
        self.pilotLicenseManager = PilotLicenseManager(dataManager: dataManager)
        
        
        let userDefaultsStorage = UserDefaultsStorage<User>()
        let cacheManager = DataManager(storage: userDefaultsStorage)
        self.userManager = UserManager(dataManager: cacheManager)
        
        
        self.coordinator = AppCoordinator(userManager: userManager)
        
        anyCancellable = coordinator.objectWillChange.sink { [weak self] _ in
            print("DependencyContainer's coordinator property has changed.")
            self?.objectWillChange.send()
        }
    
    }
}

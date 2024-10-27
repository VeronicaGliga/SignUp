//
//  UserManager.swift
//  AssesmentLHS
//
//  Created by Veronica Gliga on 26.10.2024.
//

import Foundation

class UserManager {
    // MARK: - Properties
    
    let dataManager: UserDefaultsStorage<User>
    
    // MARK: - Init
    
    init(dataManager: UserDefaultsStorage<User>) {
        self.dataManager = dataManager
    }
    
    // MARK: - Functions
    
    func userExists() -> Bool {
        fetchUser() != nil
    }
    
    func saveUser(userName: String, pilotLicenseType: PilotLicense) {
        let user = User(fullName: userName, pilotLicenseType: pilotLicenseType)
        try? dataManager.save(user, forKey: "RegisteredUser")
    }
    
    func fetchUser() -> User? {
        try? dataManager.load(forKey: "RegisteredUser")
    }
    
    func deleteUser() {
        try? dataManager.delete(forKey: "RegisteredUser")
    }
}

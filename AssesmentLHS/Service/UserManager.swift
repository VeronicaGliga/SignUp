//
//  UserManager.swift
//  AssesmentLHS
//
//  Created by Veronica Gliga on 26.10.2024.
//

import Foundation

class UserManager {
    let dataManager: DataManager<User>
    
    init(dataManager: DataManager<User>) {
        self.dataManager = dataManager
    }
    
    func userExists() -> Bool {
        fetchUser() != nil
    }
    
    func saveUser(userName: String, pilotLicenseType: PilotLicense) {
        let user = User(fullName: userName, pilotLicenseType: pilotLicenseType)
        try? dataManager.save(item: user, forKey: "RegisteredUser")
    }
    
    func fetchUser() -> User? {
        try? dataManager.load(forKey: "RegisteredUser")
    }
    
    func deleteUser() {
        try? dataManager.delete(forKey: "RegisteredUser")
    }
}

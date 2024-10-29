//
//  MockPilotLicenseManager.swift
//  AssesmentLHSTests
//
//  Created by Veronica Gliga on 29.10.2024.
//

import Foundation
@testable import AssesmentLHS

// Mock for PilotLicenseManager
class MockPilotLicenseManager: PilotLicenseProtocol {
    func fetchPilotLicense(from path: String) async throws -> Pilot {
        Pilot(pilotLicenses: [PilotLicense(type: "test", aircrafts: [])])
    }
}

// Mock for UserManager
class MockUserManager: UserManagerProtocol {
    func userExists() -> Bool { true }
    
    func saveUser(userName: String, pilotLicenseType: PilotLicense) { }
    
    func fetchUser() -> User? { nil }
    
    func deleteUser() { }
    
    
}

// Mock for AppCoordinator
class MockAppCoordinator: AppCoordinator {
    init() {
        super.init(userManager: MockUserManager())
    }
}

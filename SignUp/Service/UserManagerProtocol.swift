//
//  UserManagerProtocol.swift
//  SignUp
//
//  Created by Veronica Gliga on 29.10.2024.
//

import Foundation

protocol UserManagerProtocol {
    func userExists() -> Bool
    func saveUser(userName: String, pilotLicenseType: PilotLicense)
    func fetchUser() -> User?
    func deleteUser()
}

//
//  SignUpViewModel.swift
//  AssesmentLHS
//
//  Created by Veronica Gliga on 24.10.2024.
//

import Foundation

@MainActor
class SignUpViewModel: ObservableObject {
    // MARK: - Properties
    
    let pilotLicenseManager: PilotLicenseManager
    let userManager: UserManager
    @Published var coordinator: AppCoordinator
    
    @Published var pilotLicenceTypes = [String]()
    @Published var errorMessage = ""
    
    @Published var fullName = ""
    @Published var password = ""
    @Published var checkPassword = ""
    @Published var selectedLicenseType = ""
    
    private var licenses = [PilotLicense]()
    
    // MARK: - Init
    
    init(pilotLicenseManager: PilotLicenseManager, 
         userManager: UserManager,
         coordinator: AppCoordinator) {
        self.pilotLicenseManager = pilotLicenseManager
        self.userManager = userManager
        self.coordinator = coordinator
    }
    
    // MARK: - Functions
    
    func getPilotLicenses() {
        Task {
            do {
                licenses = try await pilotLicenseManager.fetchPilotLicense(from: "PilotLicenses").pilotLicenses
                pilotLicenceTypes = licenses.map { $0.type }
            } catch {
                errorMessage = error.localizedDescription
            }
        }
    }
    
    func registerUser() {
        guard let pilotLicenseType = licenses.first(where: { $0.type == selectedLicenseType }) else {
            errorMessage = NetworkError.noData.localizedDescription
            return
        }
        userManager.saveUser(userName: fullName, pilotLicenseType: pilotLicenseType)
        coordinator.navigateToConfirmation()
    }
    
    func validateInput() -> Bool {
        let isNameValid = !fullName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        let isPilotLicenseValid = pilotLicenceTypes.contains(selectedLicenseType)
        let isPasswordValid = isPasswordValid()
        let isCheckedPasswordValid = password == checkPassword
        
        return isNameValid && isPilotLicenseValid && isPasswordValid && isCheckedPasswordValid
    }
    
    private func isPasswordValid() -> Bool {
        // Check for at least 12 characters
        guard password.count >= 12 else {
            return false
        }
        
        // Check if username is not in password (case insensitive)
        if fullName.lowercased()
            .split(separator: " ")
            .contains(where: { password.lowercased().contains($0) }) {
            return false
        }
        
        // Initialize flags for character requirements
        var hasUppercase = false
        var hasLowercase = false
        var hasDigit = false
        
        // Iterate over each character in password to check requirements
        for char in password {
            if char.isUppercase {
                hasUppercase = true
            } else if char.isLowercase {
                hasLowercase = true
            } else if char.isNumber {
                hasDigit = true
            }
            
            // If all conditions are met, break early
            if hasUppercase && hasLowercase && hasDigit {
                return true
            }
        }
        
        // If any requirement is missing, return false
        return false
    }
}

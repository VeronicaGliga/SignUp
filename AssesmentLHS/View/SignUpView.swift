//
//  ContentView.swift
//  AssesmentLHS
//
//  Created by Veronica Gliga on 23.10.2024.
//

import SwiftUI

struct SignUpView: View {
    /// View Properties
    
    @ObservedObject var coordinator: AppCoordinator
    @State private var fullName = ""
    @State private var password = ""
    @State private var checkPassword = ""
    @State private var pilotLicenseType = ""
    
    @StateObject var viewModel = SignUpViewModel(dataManager: DataManager())
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15, content: {
            Text("SignUp")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .padding(.top, 25)
            
            Text("Please sign up to continue")
                .font(.callout)
                .fontWeight(.semibold)
                .foregroundStyle(.gray)
                .padding(.top, -5)
            
            VStack(spacing: 25) {
                /// Custom Text Fields
                
                CustomTF(sfIcon: "person", hint: "Full Name", value: $fullName)
                    .padding(.top, 5)
                
                CustomTF(sfIcon: "person", hint: "Pilot License Type", isDropdown: true, options: viewModel.pilotLicenceTypes, value: $pilotLicenseType)
                    .onAppear {
                        viewModel.getPilotLicenses()
                    }
                
                CustomTF(sfIcon: "lock", hint: "Password", isPassword: true, value: $password)
                    .padding(.top, 5)
                
                CustomTF(sfIcon: "at", hint: "Password Verification", isPassword: true, value: $checkPassword)
                
                Text("By signing up, you're agreeing to our **[Terms & Condition](https://apple.com)** and **[Privacy Policy](https://apple.com)**")
                    .font(.caption)
                    .tint(.appYellow)
                    .foregroundStyle(.gray)
                    .frame(height: 50)
                
                /// SignUp Button
                GradientButton(title: "Continue", icon: "arrow.right") {
                   // Action
                    coordinator.navigateToConfirmation()
                }
                .hSpacing(.trailing)
                /// Disabling Until the Data is Entered
                .disableWithOpacity(!validateInput(name: fullName, pilotLicense: pilotLicenseType, password: password, checkPassword: checkPassword))
            }
            .padding(.top, 20)
            
            Spacer(minLength: 0)
        })
        .padding(.vertical, 15)
        .padding(.horizontal, 25)
        .toolbar(.hidden, for: .navigationBar)
    }
    
    private func validateInput(name: String, 
                               pilotLicense: String,
                               password: String,
                               checkPassword: String) -> Bool {
        let isNameValid = !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        let isPilotLicenseValid = viewModel.pilotLicenceTypes.contains(pilotLicense)
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

#Preview {
    ContentView()
}

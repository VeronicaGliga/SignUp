//
//  ContentView.swift
//  AssesmentLHS
//
//  Created by Veronica Gliga on 23.10.2024.
//

import SwiftUI

struct SignUp: View {
    /// View Properties
    @StateObject var viewModel = SignUpViewModel(dataManager: DataManager())
    @State private var fullName = ""
    @State private var password = ""
    @State private var checkPassword = ""
    @State private var pilotLicenseType = ""
    
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
                }
                .hSpacing(.trailing)
                /// Disabling Until the Data is Entered
                .disableWithOpacity(fullName.isEmpty || password.isEmpty || checkPassword.isEmpty)
            }
            .padding(.top, 20)
            
            Spacer(minLength: 0)
        })
        .padding(.vertical, 15)
        .padding(.horizontal, 25)
        .toolbar(.hidden, for: .navigationBar)
    }
}

#Preview {
    SignUp()
}

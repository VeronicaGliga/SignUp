//
//  ContentView.swift
//  AssesmentLHS
//
//  Created by Veronica Gliga on 23.10.2024.
//

import SwiftUI

struct SignUpView: View {
    // MARK: - Properties
    
    @ObservedObject var viewModel: SignUpViewModel
    
    @State private var nameErrorMessage = ""
    @State private var licenseErrorMessage = ""
    @State private var passwordErrorMessage = ""
    @State private var checkPasswordErrorMessage = ""
    
    // MARK: - Body
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
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
                CustomTextField(sfIcon: "person",
                                hint: "Full Name",
                                value: $viewModel.fullName,
                                validationErrorMessage: $nameErrorMessage)
                .padding(.top, 5)
                .onChange(of: viewModel.fullName) {
                    nameErrorMessage = viewModel.isNameValid()
                }
                
                CustomTextField(sfIcon: "doc.text",
                                hint: "Pilot License Type",
                                isDropdown: true,
                                options: viewModel.pilotLicenceTypes,
                                value: $viewModel.selectedLicenseType,
                                validationErrorMessage: $licenseErrorMessage)
                .onAppear {
                    viewModel.getPilotLicenses()
                }
                .onChange(of: viewModel.selectedLicenseType) {
                    licenseErrorMessage = viewModel.isPilotLicenseValid()
                }
                
                CustomTextField(sfIcon: "lock",
                                hint: "Password",
                                isPassword: true,
                                value: $viewModel.password,
                                validationErrorMessage: $passwordErrorMessage)
                .padding(.top, 5)
                .onChange(of: viewModel.password) {
                    passwordErrorMessage = viewModel.isPasswordValid()
                }
                
                CustomTextField(sfIcon: "checkmark.shield",
                                hint: "Password Verification",
                                isPassword: true,
                                value: $viewModel.checkPassword,
                                validationErrorMessage: $checkPasswordErrorMessage)
                .onChange(of: viewModel.checkPassword) {
                    checkPasswordErrorMessage = viewModel.isCheckedPasswordValid()
                }
                
                Text("By signing up, you're agreeing to our **[Terms & Condition](https://apple.com)** and **[Privacy Policy](https://apple.com)**")
                    .font(.caption)
                    .tint(.appYellow)
                    .foregroundStyle(.gray)
                    .frame(height: 50)
                
                /// SignUp Button
                GradientButton(title: "Continue",
                               icon: "arrow.right") {
                    viewModel.registerUser()
                }
                               .frame(maxWidth: .infinity, alignment: .trailing)
                /// Disabling Until the Data is Valid
                               .disableWithOpacity(!viewModel.validateInput())
            }
            .padding(.top, 20)
            
            Spacer(minLength: 0)
        }
        .padding(.vertical, 15)
        .padding(.horizontal, 25)
        .toolbar(.hidden, for: .navigationBar)
    }
}

#Preview {
    ContentView()
}

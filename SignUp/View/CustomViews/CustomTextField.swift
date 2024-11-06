//
//  CustomTextField.swift
//  SignUp
//
//  Created by Veronica Gliga on 23.10.2024.
//

import SwiftUI

struct CustomTextField: View {
    // MARK: - Properties
    
    var sfIcon: String
    var iconTint: Color = .gray
    var hint: String
    var isPassword = false
    var isDropdown = false
    var options: [String] = []
    @Binding var value: String
    @Binding var validationErrorMessage: String
    
    // MARK: - View State Properties
    
    @State private var showPassword = false
    @State private var showDropdown = false
    @FocusState private var isFocused: Bool // Tracks if the field is focused
    
    // MARK: - Enum
    
    enum HideState {
        case hide, reveal
    }
    
    // MARK: - Body
    
    var body: some View {
        VStack(alignment: .leading) {
            hintOverlay
            
            HStack(alignment: .top, spacing: 8) {
                iconView
                inputField
                    .overlay(trailingButton, alignment: .trailing)
            }
            
            dropdownOptions
            
            if !validationErrorMessage.isEmpty && !isFocused {
                Text(validationErrorMessage)
                    .font(.caption)
                    .foregroundColor(.red)
                    .padding(.top, 4)
            }
        }
    }
}

// MARK: - Subviews

private extension CustomTextField {
    var hintOverlay: some View {
        Group {
            if !value.isEmpty {
                Text(hint)
                    .foregroundColor(.gray)
                    .padding(.leading, 38)
                    .allowsHitTesting(false)
            }
        }
    }
    
    var iconView: some View {
        Image(systemName: sfIcon)
            .foregroundStyle(iconTint)
            .frame(width: 30)
            .offset(y: 2)
    }
    
    @ViewBuilder
    var inputField: some View {
        VStack(alignment: .leading, spacing: 8) {
            if isPassword {
                passwordField
            } else if isDropdown {
                dropdownField
            } else {
                defaultField
            }
            Divider()
        }
    }
    
    var passwordField: some View {
        Group {
            if showPassword {
                TextField(hint, text: $value)
            } else {
                SecureField(hint, text: $value)
            }
        }
        .focused($isFocused)
    }
    
    var dropdownField: some View {
        TextField(hint, text: $value)
            .focused($isFocused)
            .onChange(of: isFocused) {
                showDropdown = isFocused
            }
    }
    
    var defaultField: some View {
        TextField(hint, text: $value)
            .focused($isFocused)
    }
    
    var trailingButton: some View {
        Group {
            if isPassword {
                Button(action: togglePasswordVisibility) {
                    Image(systemName: showPassword ? "eye.slash" : "eye")
                        .foregroundStyle(.gray)
                        .padding(10)
                        .contentShape(.rect)
                }
            } else if isDropdown {
                Button(action: toggleDropdownVisibility) {
                    Image(systemName: "chevron.down")
                        .foregroundStyle(.gray)
                        .padding(10)
                        .contentShape(.rect)
                }
            }
        }
    }
    
    var dropdownOptions: some View {
        Group {
            if showDropdown && isDropdown {
                VStack(alignment: .leading, spacing: 0) {
                    ForEach(options, id: \.self) { option in
                        Text(option)
                            .padding(.vertical, 8)
                            .padding(.horizontal)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .onTapGesture {
                                selectOption(option)
                            }
                        Divider().padding(1)
                    }
                }
                .background(Color.gray.opacity(0.2))
                .cornerRadius(5)
                .shadow(radius: 2)
                .padding(.leading, 38)
                .zIndex(1)
            }
        }
    }
}

// MARK: - Private Methods

private extension CustomTextField {
    func togglePasswordVisibility() {
        withAnimation {
            showPassword.toggle()
        }
    }
    
    func toggleDropdownVisibility() {
        withAnimation {
            showDropdown.toggle()
        }
    }
    
    func selectOption(_ option: String) {
        withAnimation {
            value = option
            showDropdown = false
        }
    }
}

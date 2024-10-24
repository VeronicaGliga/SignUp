//
//  CustomTF.swift
//  AssesmentLHS
//
//  Created by Veronica Gliga on 23.10.2024.
//

import SwiftUI

struct CustomTF: View {
    var sfIcon: String
    var iconTint: Color = .gray
    var hint: String
    var isPassword: Bool = false
    var isDropdown: Bool = false
    var options: [String] = []
    @Binding var value: String
    
    /// View Properties
    @State private var showPassword: Bool = false
    @State private var showDropdown: Bool = false
    @FocusState private var passwordState: HideState?
    
    enum HideState {
        case hide
        case reveal
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top, spacing: 8) {
                Image(systemName: sfIcon)
                    .foregroundStyle(iconTint)
                    /// Ensuring the same width to align TextFields equally
                    .frame(width: 30)
                    .offset(y: 2)
                
                VStack(alignment: .leading, spacing: 8, content: {
                    if isPassword {
                        Group {
                            /// Revealing Password when the user wants to show the password
                            if showPassword {
                                TextField(hint, text: $value)
                                    .focused($passwordState, equals: .reveal)
                            } else {
                                SecureField(hint, text: $value)
                                    .focused($passwordState, equals: .hide)
                            }
                        }
                    } else if isDropdown {
                        // Display TextField for dropdown selection
                        TextField(hint, text: $value)
                            .onTapGesture {
                                withAnimation {
                                    showDropdown.toggle()
                                }
                            }
                    } else {
                        // Default TextField
                        TextField(hint, text: $value)
                    }
                    
                    Divider()
                })
                .overlay(alignment: .trailing) {
                    if isPassword {
                        /// Password reveal button
                        Button {
                            withAnimation {
                                showPassword.toggle()
                            }
                            passwordState = showPassword ? .reveal : .hide
                        } label: {
                            Image(systemName: showPassword ? "eye.slash" : "eye")
                                .foregroundStyle(.gray)
                                .padding(10)
                                .contentShape(.rect)
                        }
                    } else if isDropdown {
                        /// Dropdown toggle button
                        Button {
                            withAnimation {
                                showDropdown.toggle()
                            }
                        } label: {
                            Image(systemName: "chevron.down")
                                .foregroundStyle(.gray)
                                .padding(10)
                                .contentShape(.rect)
                        }
                    }
                }
            }
            
            // Show dropdown options when the dropdown is open
            if showDropdown && isDropdown {
                VStack(alignment: .leading, spacing: 0) {
                    ForEach(options, id: \.self) { option in
                        Text(option)
                            .padding(.vertical, 8)
                            .padding(.horizontal)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color.white)
                            .onTapGesture {
                                withAnimation {
                                    value = option
                                    showDropdown = false
                                }
                            }
                        
                            Divider()
                                .padding(1) // optional padding for divider alignment
                        }
                }
                .background(Color.gray.opacity(0.2))
                .cornerRadius(5)
                .shadow(radius: 5)
                .zIndex(1) // Ensure it stays on top
            }
        }
    }
}

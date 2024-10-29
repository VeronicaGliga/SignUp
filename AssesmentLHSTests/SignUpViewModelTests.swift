//
//  SignUpViewModelTests.swift
//  AssesmentLHSTests
//
//  Created by Veronica Gliga on 29.10.2024.
//

import XCTest
@testable import AssesmentLHS

@MainActor
final class SignUpViewModelTests: XCTestCase {
    // MARK: - Properties
    
    var viewModel: SignUpViewModel!
    var mockPilotLicenseManager: MockPilotLicenseManager!
    var mockUserManager: MockUserManager!
    var mockCoordinator: MockAppCoordinator!
    
    // MARK: - Setup
    
    override func setUp() {
        super.setUp()
        mockPilotLicenseManager = MockPilotLicenseManager()
        mockUserManager = MockUserManager()
        mockCoordinator = MockAppCoordinator()
        viewModel = SignUpViewModel(
            pilotLicenseManager: mockPilotLicenseManager,
            userManager: mockUserManager,
            coordinator: mockCoordinator
        )
        viewModel.pilotLicenceTypes = ["Commercial", "Private"] // setting up valid license types
    }
    
    override func tearDown() {
        viewModel = nil
        mockPilotLicenseManager = nil
        mockUserManager = nil
        mockCoordinator = nil
        super.tearDown()
    }
    
    // MARK: - Name Validation Tests
    
    func testIsNameValid_withNonEmptyName_shouldReturnEmptyString() {
        viewModel.fullName = "John Doe"
        XCTAssertEqual(viewModel.isNameValid(), "", "Name validation failed for non-empty name")
    }
    
    func testIsNameValid_withEmptyName_shouldReturnErrorMessage() {
        viewModel.fullName = ""
        XCTAssertEqual(viewModel.isNameValid(), "User name should contain at least one letter", "Name validation did not return expected error for empty name")
    }
    
    // MARK: - Pilot License Validation Tests
    
    func testIsPilotLicenseValid_withValidLicenseType_shouldReturnEmptyString() {
        viewModel.selectedLicenseType = "Commercial"
        XCTAssertEqual(viewModel.isPilotLicenseValid(), "", "License validation failed for valid license type")
    }
    
    func testIsPilotLicenseValid_withInvalidLicenseType_shouldReturnErrorMessage() {
        viewModel.selectedLicenseType = "InvalidLicenseType"
        XCTAssertEqual(viewModel.isPilotLicenseValid(), "A valid Pilot License should be inserted", "License validation did not return expected error for invalid license type")
    }
    
    // MARK: - Password Validation Tests
    
    func testIsPasswordValid_withValidPassword_shouldReturnEmptyString() {
        viewModel.fullName = "John Doe"
        viewModel.password = "StrongPassword123"
        XCTAssertEqual(viewModel.isPasswordValid(), "", "Password validation failed for valid password")
    }
    
    func testIsPasswordValid_withShortPassword_shouldReturnErrorMessage() {
        viewModel.password = "Short1"
        XCTAssertEqual(viewModel.isPasswordValid(), "Password must contain at least 12 characters", "Password validation did not return expected error for short password")
    }
    
    func testIsPasswordValid_withPasswordContainingUserName_shouldReturnErrorMessage() {
        viewModel.fullName = "John Doe"
        viewModel.password = "JohnDoe12345"
        XCTAssertEqual(viewModel.isPasswordValid(), "Password should not contain user name", "Password validation did not return expected error when password contains user name")
    }
    
    func testIsPasswordValid_withPasswordMissingUppercaseLowercaseOrNumber_shouldReturnErrorMessage() {
        viewModel.password = "lowercaseonly"
        XCTAssertEqual(viewModel.isPasswordValid(), "Password must contain a combination of uppercased, lowercased and numbers", "Password validation did not return expected error when password lacks required character types")
    }
    
    // MARK: - Check Password Validation Tests
    
    func testIsCheckedPasswordValid_withMatchingPasswords_shouldReturnEmptyString() {
        viewModel.password = "ValidPassword123"
        viewModel.checkPassword = "ValidPassword123"
        XCTAssertEqual(viewModel.isCheckedPasswordValid(), "", "Check password validation failed for matching passwords")
    }
    
    func testIsCheckedPasswordValid_withNonMatchingPasswords_shouldReturnErrorMessage() {
        viewModel.password = "ValidPassword123"
        viewModel.checkPassword = "DifferentPassword"
        XCTAssertEqual(viewModel.isCheckedPasswordValid(), "Must be identical to the password", "Check password validation did not return expected error for non-matching passwords")
    }
}

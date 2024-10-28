//
//  SignUpViewUITests.swift
//  AssesmentLHSUITests
//
//  Created by Veronica Gliga on 28.10.2024.
//

import XCTest

class SignUpViewUITests: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        
        // This will stop the test immediately when a failure occurs.
        continueAfterFailure = false
        
        // Launch the app before each test.
        app.launch()
    }
    
    func testSignUpViewElementsExist() {
        // Verify the existence of essential UI elements on the signup view
        XCTAssertTrue(app.staticTexts["SignUp"].exists, "The Sign Up title should be present")
        XCTAssertTrue(app.staticTexts["Please sign up to continue"].exists, "The description text should be present")
        
        XCTAssertTrue(app.textFields["Full Name"].exists, "The Full Name text field should be present")
        XCTAssertTrue(app.textFields["Pilot License Type"].exists, "The Email text field should be present")
        XCTAssertTrue(app.secureTextFields["Password"].exists, "The Password text field should be present")
        XCTAssertTrue(app.secureTextFields["Password Verification"].exists, "The Password Verification text field should be present")
        
        XCTAssertTrue(app.buttons["Continue"].exists, "The Sign Up button should be present")
    }
    
    func testSignUpWithValidData() {
        // Enter valid data and attempt to sign up
        let fullNameTextField = app.textFields["Full Name"]
        let licenseTextField = app.textFields["Pilot License Type"]
        let passwordTextField = app.secureTextFields["Password"]
        let checkpasswordTextField = app.secureTextFields["Password Verification"]
        let signUpButton = app.buttons["Continue"]
        
        // Interacting with text fields
        fullNameTextField.tap()
        fullNameTextField.typeText("John Doe")
        
        licenseTextField.tap()
        licenseTextField.typeText("")
        
        passwordTextField.tap()
        passwordTextField.typeText("SecurePassword123")
        
        let toggleVisibilityButton = app.buttons["Show"]
        toggleVisibilityButton.tap()
        
        checkpasswordTextField.tap()
        checkpasswordTextField.typeText("SecurePassword123")
        
        app.keyboards.buttons["Return"].tap()
        signUpButton.tap()
        
        // Verify transition to the confirmation view or success message
        let confirmationMessage = app.staticTexts["Welcome, John Doe"]
        XCTAssertTrue(confirmationMessage.waitForExistence(timeout: 5), "The confirmation message should be displayed on successful sign up")
    }
    
    func testSignUpWithInvalidEmail() {
        // Attempt to sign up with an invalid email address
        let emailTextField = app.textFields["Email"]
        let signUpButton = app.buttons["SignUpButton"]
        
        emailTextField.tap()
        emailTextField.typeText("invalidemail") // Invalid email format
        
        signUpButton.tap()
        
        // Verify that an error message appears
        let emailError = app.staticTexts["Invalid email address"]
        XCTAssertTrue(emailError.waitForExistence(timeout: 5), "An error message should be displayed for an invalid email format")
    }
    
    func testSignUpWithEmptyPassword() {
        // Attempt to sign up with an empty password
        let fullNameTextField = app.textFields["Full Name"]
        let emailTextField = app.textFields["Email"]
        let signUpButton = app.buttons["SignUpButton"]
        
        // Enter valid name and email but leave password empty
        fullNameTextField.tap()
        fullNameTextField.typeText("John Doe")
        
        emailTextField.tap()
        emailTextField.typeText("john.doe@example.com")
        
        // Tap the Sign Up button
        signUpButton.tap()
        
        // Verify that an error message appears for empty password
        let passwordError = app.staticTexts["Password cannot be empty"]
        XCTAssertTrue(passwordError.waitForExistence(timeout: 5), "An error message should be displayed for an empty password")
    }
    
    func testSignUpWithShortPassword() {
        // Attempt to sign up with a short password
        let passwordTextField = app.secureTextFields["Password"]
        let signUpButton = app.buttons["SignUpButton"]
        
        // Enter a short password
        passwordTextField.tap()
        passwordTextField.typeText("short")
        
        signUpButton.tap()
        
        // Verify that an error message appears for a short password
        let passwordError = app.staticTexts["Password is too short"]
        XCTAssertTrue(passwordError.waitForExistence(timeout: 5), "An error message should be displayed for a password that is too short")
    }
}

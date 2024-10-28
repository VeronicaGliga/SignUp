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
}

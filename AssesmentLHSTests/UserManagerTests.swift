//
//  UserManagerTests.swift
//  AssesmentLHSTests
//
//  Created by Veronica Gliga on 28.10.2024.
//

import XCTest
@testable import AssesmentLHS

final class UserManagerTests: XCTestCase {
    
    var userManager: UserManager!
    var mockUserDefaultsStorage: MockUserDefaultsStorage!
    let testLicense = PilotLicense(type: "test type", aircrafts: ["aircraft1", "aircraft2"])
    let testUser = User(fullName: "Test User", pilotLicenseType: PilotLicense(type: "test type", aircrafts: ["aircraft1", "aircraft2"]))
    
    override func setUp() {
        super.setUp()
        mockUserDefaultsStorage = MockUserDefaultsStorage()
        userManager = UserManager(dataManager: mockUserDefaultsStorage)
    }
    
    override func tearDown() {
        userManager = nil
        mockUserDefaultsStorage = nil
        super.tearDown()
    }
    
    func testUserExistsWhenUserIsSaved() {
        let user = testUser
        mockUserDefaultsStorage.storedData = user
        
        let exists = userManager.userExists()
        
        XCTAssertTrue(exists)
    }
    
    func testUserExistsWhenUserIsNotSaved() {
        mockUserDefaultsStorage.storedData = nil
        
        let exists = userManager.userExists()
        
        XCTAssertFalse(exists)
    }
    
    func testSaveUser() {
        userManager.saveUser(userName: "Test User", pilotLicenseType: testLicense)
        
        XCTAssertNotNil(mockUserDefaultsStorage.storedData)
        XCTAssertEqual(mockUserDefaultsStorage.storedData?.fullName, "Test User")
        XCTAssertTrue(pilotLicensesAreEqual(mockUserDefaultsStorage.storedData?.pilotLicenseType, testLicense))
    }
    
    func testFetchUser() {
        let user = User(fullName: "Test User", pilotLicenseType: testLicense)
        mockUserDefaultsStorage.storedData = user
        
        let fetchedUser = userManager.fetchUser()
        
        XCTAssertEqual(fetchedUser?.fullName, user.fullName)
        XCTAssertTrue(pilotLicensesAreEqual(fetchedUser?.pilotLicenseType, user.pilotLicenseType))
    }
    
    func testDeleteUser() {
        let user = User(fullName: "Test User", pilotLicenseType: testLicense)
        mockUserDefaultsStorage.storedData = user
        
        userManager.deleteUser()
        
        XCTAssertNil(mockUserDefaultsStorage.storedData)
    }
    
    // MARK: - Private
    
    private func pilotLicensesAreEqual(_ lhs: PilotLicense?, _ rhs: PilotLicense?) -> Bool {
        return lhs?.type == rhs?.type &&
        lhs?.aircrafts == rhs?.aircrafts
    }
    
    // Helper method to compare two arrays of repositories
    private func licensesArraysAreEqual(_ lhs: [PilotLicense], _ rhs: [PilotLicense]) -> Bool {
        guard lhs.count == rhs.count else { return false }
        
        for (index, license) in lhs.enumerated() {
            if !pilotLicensesAreEqual(license, rhs[index]) {
                return false
            }
        }
        return true
    }
}

//
//  UserDefaultsStorageTests.swift
//  SignUpTests
//
//  Created by Veronica Gliga on 28.10.2024.
//

import XCTest
@testable import SignUp

final class UserDefaultsStorageTests: XCTestCase {
    
    var userDefaultsStorage: UserDefaultsStorage<SampleCodable>!
    let testKey = "testKey"
    
    override func setUp() {
        super.setUp()
        userDefaultsStorage = UserDefaultsStorage<SampleCodable>()
    }
    
    override func tearDown() {
        try? userDefaultsStorage.delete(forKey: testKey)
        userDefaultsStorage = nil
        super.tearDown()
    }
    
    func testSaveAndLoad() {
        let sampleData = SampleCodable(id: 1, name: "Test Item")
        
        XCTAssertNoThrow(try userDefaultsStorage.save(sampleData, forKey: testKey))
        
        let loadedData = try? userDefaultsStorage.load(forKey: testKey)
        XCTAssertEqual(loadedData?.id, sampleData.id)
        XCTAssertEqual(loadedData?.name, sampleData.name)
    }
    
    func testLoadNonExistentKey() {
        let loadedData = try? userDefaultsStorage.load(forKey: "nonExistentKey")
        
        XCTAssertNil(loadedData)
    }
    
    func testDeleteExistingKey() {
        let sampleData = SampleCodable(id: 1, name: "Test Item")
        try? userDefaultsStorage.save(sampleData, forKey: testKey)
        
        XCTAssertNoThrow(try userDefaultsStorage.delete(forKey: testKey))
        
        let loadedData = try? userDefaultsStorage.load(forKey: testKey)
        XCTAssertNil(loadedData)
    }
    
    func testDeleteNonExistentKey() {
        XCTAssertNoThrow(try userDefaultsStorage.delete(forKey: "nonExistentKey"))
    }
}

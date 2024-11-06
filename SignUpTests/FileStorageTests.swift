//
//  FileStorageTests.swift
//  SignUpTests
//
//  Created by Veronica Gliga on 28.10.2024.
//

import XCTest
@testable import SignUp

final class FileStorageTests: XCTestCase {
    
    var fileStorage: FileStorage<SampleCodable>!
    
    override func setUp() {
        super.setUp()
        fileStorage = FileStorage<SampleCodable>(bundle: Bundle(for: type(of: self)))
    }
    
    override func tearDown() {
        fileStorage = nil
        super.tearDown()
    }
    
    func testLoadExistingFile() {
        let fileName = "sampleData" // Ensure this JSON file exists in your bundle
        let loadedData = try? fileStorage.load(forKey: fileName)
        
        XCTAssertNotNil(loadedData)
        XCTAssertEqual(loadedData?.id, 1) // Assuming known data structure
        XCTAssertEqual(loadedData?.name, "Sample Data")
    }
    
    func testLoadNonExistentFile() {
        let nonExistentFileName = "nonExistentFile"
        let loadedData = try? fileStorage.load(forKey: nonExistentFileName)
        
        XCTAssertNil(loadedData)
    }
    
    func testLoadCorruptFile() {
        let corruptFileName = "corruptData" // Ensure this corrupt JSON file exists
        
        XCTAssertThrowsError(try fileStorage.load(forKey: corruptFileName)) { error in
            XCTAssertNotNil(error)
        }
    }
}

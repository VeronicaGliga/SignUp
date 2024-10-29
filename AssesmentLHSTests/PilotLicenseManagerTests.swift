//
//  PilotLicenseManagerTests.swift
//  AssesmentLHSTests
//
//  Created by Veronica Gliga on 28.10.2024.
//

import XCTest
@testable import AssesmentLHS

final class PilotLicenseManagerTests: XCTestCase {
    
    var pilotLicenseManager: PilotLicenseManager!
    var mockFileStorage: MockFileStorage!
    
    override func setUp() {
        super.setUp()
        mockFileStorage = MockFileStorage()
        let anyDataFetcher = AnyDataFetcher(mockFileStorage)
        pilotLicenseManager = PilotLicenseManager(dataManager: anyDataFetcher)
    }
    
    override func tearDown() {
        pilotLicenseManager = nil
        mockFileStorage = nil
        super.tearDown()
    }
    
    func testFetchPilotLicenseSuccess() async throws {
        let pilot = Pilot(pilotLicenses: [PilotLicense(type: "test type", aircrafts: ["aircraft1", "aircraft2"])])
        mockFileStorage.mockData = pilot
        
        let fetchedPilot = try await pilotLicenseManager.fetchPilotLicense(from: "samplePath")
        
        XCTAssertEqual(fetchedPilot.pilotLicenses.count, pilot.pilotLicenses.count)
        XCTAssertTrue(licensesArraysAreEqual(fetchedPilot.pilotLicenses, pilot.pilotLicenses))
    }
    
    func testFetchPilotLicenseNoData() async {
        mockFileStorage.mockData = nil
        
        do {
            _ = try await pilotLicenseManager.fetchPilotLicense(from: "samplePath")
            XCTFail("Expected noData error but did not receive it.")
        } catch let error as NetworkError {
            // Then: Assert that the error is `invalidResponse` with status code 500
            if case .noData = error {
                XCTAssertTrue(true)
            } else {
                XCTFail("Expected NetworkError.invalidResponse, but got a different error")
            }
        } catch {
            XCTFail("Unexpected error type: \(error)")
        }
    }
    
    func testFetchPilotLicenseThrowsError() async {
        mockFileStorage.shouldThrowError = true
        
        do {
            _ = try await pilotLicenseManager.fetchPilotLicense(from: "samplePath")
            XCTFail("Expected an error but did not receive it.")
        } catch {
            XCTAssertNotNil(error)
        }
    }
    
    // MARK: - Helpers
    
    private func pilotLicensesAreEqual(_ lhs: PilotLicense, _ rhs: PilotLicense) -> Bool {
        return lhs.type == rhs.type &&
        Set(lhs.aircrafts) == Set(rhs.aircrafts)
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

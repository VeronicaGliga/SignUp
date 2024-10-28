//
//  MockFileStorage.swift
//  AssesmentLHSTests
//
//  Created by Veronica Gliga on 28.10.2024.
//

import Foundation
@testable import AssesmentLHS

class MockFileStorage: FileStorage<Pilot> {
    var mockData: Pilot?
    var shouldThrowError = false
    
    override func load(forKey key: String) throws -> Pilot? {
        if shouldThrowError {
            throw NetworkError.noData
        }
        return mockData
    }
}

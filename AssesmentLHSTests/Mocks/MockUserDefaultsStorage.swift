//
//  MockUserDefaultsStorage.swift
//  AssesmentLHSTests
//
//  Created by Veronica Gliga on 28.10.2024.
//

import Foundation
@testable import AssesmentLHS

class MockUserDefaultsStorage: UserDefaultsStorage<User> {
    var storedData: User?
    
    override func save(_ item: User, forKey key: String) throws {
        storedData = item
    }
    
    override func load(forKey key: String) throws -> User? {
        return storedData
    }
    
    override func delete(forKey key: String) throws {
        storedData = nil
    }
}

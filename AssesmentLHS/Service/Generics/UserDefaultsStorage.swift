//
//  UserDefaultsStorage.swift
//  AssesmentLHS
//
//  Created by Veronica Gliga on 26.10.2024.
//

import Foundation

class UserDefaultsStorage<T: Codable>: DataFecher, DataHandler {
    // MARK: - Properties
    
    private let userDefaults = UserDefaults.standard
    
    // MARK: - Functions

    func save(_ item: T, forKey key: String) throws {
        let data = try JSONEncoder().encode(item)
        userDefaults.set(data, forKey: key)
    }

    func delete(forKey key: String) throws {
        userDefaults.removeObject(forKey: key)
    }

    func load(forKey key: String) throws -> T? {
        guard let data = userDefaults.data(forKey: key) else { return nil }
        return try JSONDecoder().decode(T.self, from: data)
    }
}

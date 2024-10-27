//
//  DataManager.swift
//  AssesmentLHS
//
//  Created by Veronica Gliga on 24.10.2024.
//

import Foundation

class DataManager<T: Codable> {
    private let storage: any DataProvider<T>

    init(storage: any DataProvider<T>) {
        self.storage = storage
    }

    func save(item: T, forKey key: String) throws {
        try storage.save(item, forKey: key)
    }

    func delete(forKey key: String) throws {
        try storage.delete(forKey: key)
    }

    func load(forKey key: String) throws -> T? {
        return try storage.load(forKey: key)
    }
}

//
//  AnyStorage.swift
//  SignUp
//
//  Created by Veronica Gliga on 29.10.2024.
//

import Foundation

struct AnyDataHandler<T>: DataHandler {
    private let _save: (T, String) throws -> Void
    private let _delete: (String) throws -> Void
    private let _load: (String) throws -> T?

    init<D: DataHandler>(_ handler: D) where D.T == T {
        self._save = handler.save
        self._delete = handler.delete
        self._load = handler.load
    }

    func save(_ item: T, forKey key: String) throws {
        try _save(item, key)
    }

    func delete(forKey key: String) throws {
        try _delete(key)
    }

    func load(forKey key: String) throws -> T? {
        try _load(key)
    }
}

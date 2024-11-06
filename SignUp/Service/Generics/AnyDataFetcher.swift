//
//  AnyDataFetcher.swift
//  SignUp
//
//  Created by Veronica Gliga on 29.10.2024.
//

import Foundation

struct AnyDataFetcher<T>: DataFetcher {
    private let _load: (String) throws -> T?

    init<D: DataFetcher>(_ handler: D) where D.T == T {
        self._load = handler.load
    }
    
    func load(forKey key: String) throws -> T? {
        try _load(key)
    }
}

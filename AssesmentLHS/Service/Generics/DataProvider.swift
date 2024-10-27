//
//  DataProvider.swift
//  AssesmentLHS
//
//  Created by Veronica Gliga on 26.10.2024.
//

import Foundation

protocol DataProvider<T> {
    associatedtype T
    
    func save(_ item: T, forKey key: String) throws
    func load(forKey key: String) throws -> T?
    func delete(forKey key: String) throws
}

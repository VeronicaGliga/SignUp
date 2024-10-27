//
//  DataFetcher.swift
//  AssesmentLHS
//
//  Created by Veronica Gliga on 27.10.2024.
//

import Foundation

protocol DataFecher<T> {
    associatedtype T
    
    func load(forKey key: String) throws -> T?
}

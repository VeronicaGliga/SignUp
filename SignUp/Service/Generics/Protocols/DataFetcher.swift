//
//  DataFetcher.swift
//  SignUp
//
//  Created by Veronica Gliga on 27.10.2024.
//

import Foundation

protocol DataFetcher<T> {
    associatedtype T
    
    func load(forKey key: String) throws -> T?
}

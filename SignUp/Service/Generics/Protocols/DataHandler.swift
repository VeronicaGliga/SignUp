//
//  DataProvider.swift
//  SignUp
//
//  Created by Veronica Gliga on 26.10.2024.
//

import Foundation

protocol DataHandler<T>: DataFetcher {
    associatedtype T
    
    func save(_ item: T, forKey key: String) throws
    func delete(forKey key: String) throws
}

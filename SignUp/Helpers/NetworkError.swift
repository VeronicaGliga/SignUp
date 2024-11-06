//
//  NetworkError.swift
//  SignUp
//
//  Created by Veronica Gliga on 24.10.2024.
//

import Foundation

enum NetworkError: Error {
    case noData
    case decodingError(Error)
}

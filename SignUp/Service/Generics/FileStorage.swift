//
//  FileStorage.swift
//  SignUp
//
//  Created by Veronica Gliga on 26.10.2024.
//

import Foundation

class FileStorage<T: Codable>: DataFetcher {
    // MARK: - Properties
    
    private let bundle: Bundle
    
    // MARK: - Init
    
    init(bundle: Bundle = Bundle.main) {
        self.bundle = bundle
    }
    
    // MARK: - Functions
    
    func load(forKey key: String) throws -> T? {
        guard let path = bundle.path(forResource: key, ofType: "json") else {
            print("File \(key) not found in the project.")
            return nil
        }
        
        let data = try Data(contentsOf: URL(fileURLWithPath: path))
        return try JSONDecoder().decode(T.self, from: data)
    }
}

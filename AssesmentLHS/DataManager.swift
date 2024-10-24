//
//  DataManager.swift
//  AssesmentLHS
//
//  Created by Veronica Gliga on 24.10.2024.
//

import Foundation

class DataManager {
    
    // A generic function that loads and decodes JSON data from a file
    func loadJSONFromFile<T: Decodable>(filename: String, as type: T.Type) async throws -> T {
        // Get the file path for the given filename
        guard let path = Bundle.main.path(forResource: filename, ofType: "json") else {
            print("File \(filename) not found in the project.")
            throw NetworkError.noData
        }
        
        // Read the data from the file
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            
            // Decode the JSON into the provided Decodable type
            let decoder = JSONDecoder()
            let decodedObject = try decoder.decode(T.self, from: data)
            
            return decodedObject
        } catch {
            print("Failed to load or decode JSON: \(error.localizedDescription)")
            throw NetworkError.decodingError(error)
        }
    }
}

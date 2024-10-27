//
//  FileStorage.swift
//  AssesmentLHS
//
//  Created by Veronica Gliga on 26.10.2024.
//

import Foundation

class FileStorage<T: Codable>: DataProvider {
    private let fileManager = FileManager.default

    func save(_ item: T, forKey key: String) throws {
//        let fileURL = directoryURL.appendingPathComponent("\(key).json")
//        let data = try JSONEncoder().encode(item)
//        try data.write(to: fileURL)
    }

    func delete(forKey key: String) throws {
//        let fileURL = directoryURL.appendingPathComponent("\(key).json")
//        if fileManager.fileExists(atPath: fileURL.path) {
//            try fileManager.removeItem(at: fileURL)
//        }
    }

    func load(forKey key: String) throws -> T? {
        guard let path = Bundle.main.path(forResource: key, ofType: "json") else {
            print("File \(key) not found in the project.")
            return nil
        }
        
        let data = try Data(contentsOf: URL(fileURLWithPath: path))
        return try JSONDecoder().decode(T.self, from: data)
    }
}

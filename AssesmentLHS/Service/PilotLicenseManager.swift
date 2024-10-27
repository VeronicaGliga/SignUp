//
//  PilotLicenseManager.swift
//  AssesmentLHS
//
//  Created by Veronica Gliga on 26.10.2024.
//

import Foundation

class PilotLicenseManager: ObservableObject {
    let dataManager: DataManager<Pilot>
    
    init(dataManager: DataManager<Pilot>) {
        self.dataManager = dataManager
    }
    
    func fetchPilotLicense(from path: String) async throws -> Pilot {
        do {
            if let pilotData = try dataManager.load(forKey: path) {
                return pilotData
            } else {
                throw NetworkError.noData
            }
        } catch {
            throw error
        }
    }
}

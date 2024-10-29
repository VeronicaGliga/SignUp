//
//  PilotLicenseManager.swift
//  AssesmentLHS
//
//  Created by Veronica Gliga on 26.10.2024.
//

import Foundation

class PilotLicenseManager: PilotLicenseProtocol {
    // MARK: - Properties
    
    let dataManager: AnyDataFetcher<Pilot>
    
    // MARK: - Init
    
    init(dataManager: AnyDataFetcher<Pilot>) {
        self.dataManager = dataManager
    }
    
    // MARK: - Functions
    
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

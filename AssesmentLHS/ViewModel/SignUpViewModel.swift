//
//  SignUpViewModel.swift
//  AssesmentLHS
//
//  Created by Veronica Gliga on 24.10.2024.
//

import Foundation

@MainActor
class SignUpViewModel: ObservableObject {
    let dataManager: DataManager
    
    @Published var pilotLicenceTypes = [String]()
    @Published var errorMessage = ""
    
    init(dataManager: DataManager) {
        self.dataManager = dataManager
    }
    
    func getPilotLicenses() {
        Task {
            do {
                let licenses = try await dataManager.loadJSONFromFile(filename: "PilotLicenses", as: Pilot.self)
                pilotLicenceTypes = licenses.pilotLicenses.map { $0.type }
            } catch {
                errorMessage = error.localizedDescription
            }
        }
    }
}

//
//  ConfirmationViewModel.swift
//  AssesmentLHS
//
//  Created by Veronica Gliga on 26.10.2024.
//

import Foundation

class ConfirmationViewModel: ObservableObject {
    @Published var userName: String
    @Published var pilotLicense: PilotLicense
    
    init(userName: String, pilotLicense: PilotLicense) {
        self.userName = userName
        self.pilotLicense = pilotLicense
    }
}

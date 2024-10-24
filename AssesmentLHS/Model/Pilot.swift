//
//  Pilot.swift
//  AssesmentLHS
//
//  Created by Veronica Gliga on 24.10.2024.
//

import Foundation

struct Pilot: Decodable {
    let pilotLicenses: [PilotLicense]
    
    enum CodingKeys: String, CodingKey {
        case pilotLicenses = "pilot-licenses"
    }
}

//
//  PilotLicense.swift
//  AssesmentLHS
//
//  Created by Veronica Gliga on 24.10.2024.
//

import Foundation

struct PilotLicense: Decodable {
    let type: String
    let aircrafts: [String]
}

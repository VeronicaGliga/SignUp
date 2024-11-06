//
//  PilotLicenseProtocol.swift
//  SignUp
//
//  Created by Veronica Gliga on 29.10.2024.
//

import Foundation

protocol PilotLicenseProtocol {
    func fetchPilotLicense(from path: String) async throws -> Pilot
}

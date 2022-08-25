//
//  Response.swift
//  Paythru
//
//  Created by emile on 24/08/2022.
//

import Foundation

struct Response: Codable {
    let name: String
    let country: [Country]
    let created: Date?
}

// MARK: - Equatable
extension Response: Equatable {
    // swiftlint: disable operator_whitespace
    static func ==(lhs: Response, rhs: Response) -> Bool {
        return lhs.name == rhs.name && lhs.country == rhs.country
    }
    // swiftlint: enable operator_whitespace
}

// MARK: - Hashable
extension Response: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(created)
    }
}

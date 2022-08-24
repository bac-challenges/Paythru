//
//  Country.swift
//  Paythru
//
//  Created by emile on 24/08/2022.
//

import Foundation

struct Country: Codable, Hashable, Equatable {

    enum CodingKeys: String, CodingKey {
        case code = "country_id"
        case probability = "probability"
    }

    let code: String
    let probability: Double

    // swiftlint: disable operator_whitespace
    static func ==(lhs: Country, rhs: Country) -> Bool {
        return lhs.code == rhs.code
    }
    // swiftlint: enable operator_whitespace
}

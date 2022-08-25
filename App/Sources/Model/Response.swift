//
//  Response.swift
//  Paythru
//
//  Created by emile on 24/08/2022.
//

import Foundation

struct Response: Codable, Hashable, Equatable {

    let name: String
    let country: [Country]

    // swiftlint: disable operator_whitespace
    static func ==(lhs: Response, rhs: Response) -> Bool {
        return lhs.name == rhs.name && lhs.country == rhs.country
    }
    // swiftlint: enable operator_whitespace
}

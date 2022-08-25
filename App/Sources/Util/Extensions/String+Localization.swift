//
//  String+Localization.swift
//  Paythru
//
//  Created by emile on 24/08/2022.
//

import Foundation

public extension String {
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
}

// swiftlint: disable operator_whitespace
prefix operator ~
prefix public func ~(string: String) -> String {
    return NSLocalizedString(string, comment: "")
}
// swiftlint: enable operator_whitespace

//
//  SectionType.swift
//  Paythru
//
//  Created by emile on 25/08/2022.
//

import Foundation

enum SectionType {

    case history
    case search

    var icon: String {
        switch self {
        case .search: return "magnifyingglass"
        case .history: return "clock"
        }
    }

    var title: String {
        switch self {
        case .search: return ~"RESULTS"
        case .history: return ~"HISTORY"
        }
    }

    var error: String {
        switch self {
        case .search: return ~"NO_RESULTS"
        case .history: return ~"NO_HISTORY"
        }
    }
}

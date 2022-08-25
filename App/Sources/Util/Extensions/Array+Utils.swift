//
//  Array+Utils.swift
//  Paythru
//
//  Created by emile on 25/08/2022.
//

import Foundation

extension Array {
    subscript(safe range: Range<Index>) -> ArraySlice<Element> {
        return self[Swift.min(range.startIndex, self.endIndex)..<Swift.min(range.endIndex, self.endIndex)]
    }
}

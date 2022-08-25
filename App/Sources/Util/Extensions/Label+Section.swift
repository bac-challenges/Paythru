//
//  Label+Section.swift
//  Paythru
//
//  Created by emile on 25/08/2022.
//

import SwiftUI

extension Label where Title == Text, Icon == Image {
    init(_ state: SectionType, isError: Bool = false) {
        self.init(isError ? state.error:state.title, systemImage: state.icon)
    }
}

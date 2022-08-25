//
//  SectionContainer.swift
//  Paythru
//
//  Created by emile on 25/08/2022.
//

import SwiftUI

struct SectionContainer<Row: View, Action: View, Footer: View, T: Hashable>: View {

    private let items: [T]
    private let type: SectionType
    private let action: () -> Action?
    private let footer: () -> Footer?
    private let row: (T) -> Row

    // swiftlint: disable all
    init(items: [T],
         type: SectionType,
         @ViewBuilder row: @escaping (T) -> Row,
         @ViewBuilder action: @escaping () -> Action? = {EmptyView()},
         @ViewBuilder footer: @escaping () -> Footer? = {EmptyView()}) {

        self.items = items
        self.type = type
        self.action = action
        self.footer = footer
        self.row = row
    }
    // swiftlint: enable all

    var body: some View {
        if items.isEmpty {
            Label(type, isError: true)
        } else {
            Section(header: Label(type), footer: footer()) {
                ForEach(items, id: \.self) { item in
                    withAnimation {
                        row(item)
                    }
                }

                action()
            }
        }
    }
}

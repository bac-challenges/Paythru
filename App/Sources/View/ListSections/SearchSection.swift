//
//  SearchSection.swift
//  Paythru
//
//  Created by emile on 25/08/2022.
//

import SwiftUI

struct SearchSection: View {

    @ObservedObject
    var viewModel: ViewModel

    var body: some View {
        SectionContainer(items: viewModel.items, type: .search) { item in
            SearchRow(item: item)
        }
    }
}

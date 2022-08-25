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
        if viewModel.items.isEmpty {
            Label(.search, isError: true).navigationTitle(viewModel.name)
        } else {
            Section {
                ForEach(viewModel.items, id: \.self) { item in
                    withAnimation {
                        HStack {
                            Text(~"COUNTRY" + ": \(item.code)").foregroundColor(.secondary)
                            Spacer()
                            Text(String(format: ~"PROBABILITY", item.probability)).foregroundColor(.secondary)
                        }.navigationTitle(viewModel.name)
                    }
                }
            } header: {
                Label(.search)
            }
        }
    }
}

//
//  HistorySection.swift
//  Paythru
//
//  Created by emile on 25/08/2022.
//

import SwiftUI

struct HistorySection: View {

    @ObservedObject
    var viewModel: ViewModel

    var body: some View {
        if viewModel.history.isEmpty {
            Label(.history, isError: true).navigationTitle(viewModel.name)
        } else {
            Section {
                ForEach(viewModel.history, id: \.self) { item in
                    Text(item.name)
                }

                HStack {
                    Spacer()
                    Button(viewModel.showFullHistory ? ~"SHOW_SHORT_HISTORY":~"SHOW_FULL_HISTORY") {
                        withAnimation {
                            viewModel.showFullHistory.toggle()
                        }
                    }
                    Spacer()
                }
            } header: {
                Label(.history)
            }
        }
    }
}

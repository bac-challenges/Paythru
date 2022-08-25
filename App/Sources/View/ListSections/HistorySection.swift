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
        SectionContainer(items: viewModel.history, type: .history, row: row, action: action, footer: footer)
    }

    private func row(_ item: Response) -> some View {
        Button {
            Task { await viewModel.showHistory(item) }
        } label: {
            Label(item.name, systemImage: "person.crop.circle")
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        }
    }

    private func action() -> some View {
        Button(viewModel.showingFullHistory ? ~"SHOW_SHORT_HISTORY":~"SHOW_FULL_HISTORY") {
            Task { await viewModel.showFullHistory() }
        }
        .multilineTextAlignment(.center)
        .frame(maxWidth: .infinity)
    }

    private func footer() -> some View {
        Text("\(viewModel.historyCount) more items")
            .multilineTextAlignment(.center)
            .frame(maxWidth: .infinity)
            .font(.footnote)
    }
}

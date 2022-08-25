//
//  ContentView.swift
//  Paythru
//
//  Created by emile on 24/08/2022.
//

import SwiftUI

struct ContentView: View {

    @StateObject
    private var viewModel = ViewModel()

    var body: some View {
        SearchBar(viewModel: viewModel) {
            results()
        }.padding(40)
    }
}

// MARK: - UI
extension ContentView {
    private func results() -> some View {
        NavigationView {
            List {
                SearchSection(viewModel: viewModel)
                HistorySection(viewModel: viewModel)
            }
            .listStyle(.insetGrouped)
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button(~"CLOSE", action: viewModel.close)
                }
            }
        }
    }
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

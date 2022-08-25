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
            ContriesList(viewModel: viewModel) {
                SearchSection(viewModel: viewModel)
                HistorySection(viewModel: viewModel)
            }
        }.padding(40)
    }
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

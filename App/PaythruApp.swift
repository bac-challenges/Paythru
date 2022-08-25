//
//  PaythruApp.swift
//  Paythru
//
//  Created by emile on 24/08/2022.
//

import SwiftUI

@main
struct PaythruApp: App {

    @StateObject
    private var viewModel = ViewModel()

    var body: some Scene {
        WindowGroup {
            SearchBar(viewModel: viewModel) {
                ContriesList(viewModel: viewModel) {
                    SearchSection(viewModel: viewModel)
                    HistorySection(viewModel: viewModel)
                }
            }.padding(20)
        }
    }
}

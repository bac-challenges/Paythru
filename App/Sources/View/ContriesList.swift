//
//  ContriesList.swift
//  Paythru
//
//  Created by emile on 25/08/2022.
//

import SwiftUI

struct ContriesList<Content: View>: View {

    @ObservedObject
    var viewModel: ViewModel

    let content: Content

    init(viewModel: ViewModel, @ViewBuilder content: () -> Content) {
        self.viewModel = viewModel
        self.content = content()
    }

    var body: some View {
        NavigationView {
            List {
                content
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

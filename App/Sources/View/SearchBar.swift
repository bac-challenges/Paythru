//
//  SearchBar.swift
//  Paythru
//
//  Created by emile on 25/08/2022.
//

import SwiftUI

struct SearchBar<Content: View>: View {

    @ObservedObject
    private var viewModel: ViewModel

    @State
    private var showingSheet = false

    let content: Content

    init(viewModel: ViewModel, @ViewBuilder content: () -> Content) {
        self.viewModel = viewModel
        self.content = content()
    }

    var body: some View {
        HStack {
            TextField(~"ENTER_YOUR_NAME", text: $viewModel.name)
                .textFieldStyle(.roundedBorder)
                .foregroundColor(.accentColor)
                .textCase(.lowercase)
                .animation(.easeIn, value: viewModel.opacity)
                .onSubmit { search() }
                .overlay(alignment: .trailing) {

                    Button {
                        Task { await viewModel.clear() }
                    } label: {
                        Image(systemName: "xmark.circle")
                    }
                    .foregroundColor(.accentColor)
                    .opacity(viewModel.opacity)
                    .padding(.trailing, 5)
                }

            Button(~"SEARCH", action: search)
                .opacity(viewModel.opacity)
                .padding(.trailing, viewModel.padding)
                .animation(.easeIn, value: viewModel.opacity)
                .animation(.easeIn, value: viewModel.padding)
                .sheet(isPresented: $showingSheet) { content }
        }
    }

    private func search() {
        showingSheet.toggle()
        viewModel.search()
    }
}

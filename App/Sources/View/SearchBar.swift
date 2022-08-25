//
//  SearchBar.swift
//  Paythru
//
//  Created by emile on 25/08/2022.
//

import SwiftUI

struct SearchBar: View {
    var body: some View {
        HStack {
            TextField(~"ENTER_YOUR_NAME", text: $viewModel.name)
                .textFieldStyle(.roundedBorder)
                .foregroundColor(.accentColor)
                .textCase(.lowercase)
                .animation(.easeIn, value: viewModel.opacity)
                .onSubmit { viewModel.search() }
                .overlay(alignment: .trailing) {
                    Button(action: viewModel.clear) {
                        Image(systemName: "xmark.circle")
                    }
                    .foregroundColor(.accentColor)
                    .opacity(viewModel.opacity)
                    .padding(.trailing, 5)
                }
            
            Button(~"SEARCH", action: viewModel.search)
                .opacity(viewModel.opacity)
                .padding(.trailing, viewModel.padding)
                .animation(.easeIn, value: viewModel.opacity)
                .animation(.easeIn, value: viewModel.padding)
                .sheet(isPresented: $viewModel.showingSheet) { results() }
        }
    }
}

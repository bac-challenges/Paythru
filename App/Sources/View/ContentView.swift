//
//  ContentView.swift
//  Paythru
//
//  Created by emile on 24/08/2022.
//

import SwiftUI

struct ContentView: View {

    @ObservedObject
    private var viewModel = ViewModel()

    var body: some View {
        search().padding(40)
    }
}

// MARK: - UI
extension ContentView {
    private func search() -> some View {
        VStack {
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

    private func results() -> some View {
        NavigationView {
            List {
                if viewModel.items.isEmpty {
                    Label(.search, isError: true)
                        .navigationTitle(viewModel.name)
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

                if viewModel.history.isEmpty {
                    Label(.history, isError: true)
                        .navigationTitle(viewModel.name)
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

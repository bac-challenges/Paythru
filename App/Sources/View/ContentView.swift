//
//  ContentView.swift
//  Paythru
//
//  Created by emile on 24/08/2022.
//

import SwiftUI

struct ContentView: View {

    @StateObject
    private var repository = RemoteRepository()

    @State
    private var name = ""

    var body: some View {
        VStack {
            search()
            results()
        }
        .padding(40)
    }

    private func search() {
        repository.get(name: name)
    }
}

// MARK: - UI
extension ContentView {

    private func search() -> some View {
        HStack {
            TextField(~"ENTER_YOUR_NAME", text: $name)
                .textFieldStyle(.roundedBorder)
            Button(~"SEARCH", action: search)
        }
    }

    private func results() -> some View {
        List(repository.items, id: \.self) { item in
            HStack {
                Text("Country: \(item.code)")
                Spacer()
                Text(String(format: "Probability: %.2f", item.probability))
            }
        }.listStyle(.plain)
    }
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

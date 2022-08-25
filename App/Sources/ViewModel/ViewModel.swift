//
//  ViewModel.swift
//  Paythru
//
//  Created by emile on 24/08/2022.
//

import Foundation
import Combine
import SwiftUI

@MainActor
final class ViewModel: ObservableObject {

    @Published var items = [Country]()
    @Published var name = ""
    @Published private(set) var showingFullHistory = false

    @Injected(\.service)
    private var service: Service

    @BundleBacked<String>(key: "api-url")
    private var baseurl: String?

    private var cache = [String: Response]()
    private var cancelBag = CancelBag()

    init() { cache.load() }

    func search() {

        items = [Country]()

        if let item = cache[name] {
            items = item.country
        } else {
            service.get(url(name: name))
                .decode(type: Response.self, decoder: JSONDecoder())
                .receive(on: RunLoop.main)
                .sink { error in
                    print(error)
                } receiveValue: { [weak self] item in
                    self?.items = item.country
                    self?.cache[item.name] = item
                    self?.cache.save()
                }
                .store(in: cancelBag)
        }
    }

    var history: [Response] {
        showingFullHistory ? cache.toArray():Array(cache.toArray()[0...2])
    }

    var historyCount: Int {
        cache.count - 3
    }

    var isActive: Bool {
        name != ""
    }

    var opacity: Double {
        isActive ? 1:0
    }

    var padding: Double {
        isActive ? 0:-200
    }
}

// MARK: - Actions
extension ViewModel {

    func showFullHistory() async {
        showingFullHistory.toggle()
    }

    func showHistory(_ item: Response) async {
        name = item.name
        items = item.country
    }

    func clear() async {
        name = ""
    }
}

// MARK: - URL Helper
extension ViewModel {
    private func url(name: String) -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = baseurl
        components.path = ""
        components.queryItems = [URLQueryItem(name: "name", value: name)]

        guard let url = components.url else { fatalError("Bad URL...") }

        return url
    }
}

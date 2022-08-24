//
//  ViewModel.swift
//  Paythru
//
//  Created by emile on 24/08/2022.
//

import Foundation
import Combine

// MARK: -
final class ViewModel: ObservableObject {

    @Published
    var items = [Country]()

    @Injected(\.service)
    private var service: Service

    @BundleBacked<String>(key: "api-url")
    private var baseurl

    private var cache = [String: Response]()
    private var cancelBag = CancelBag()

    init() { cache.load() }

    func search(name: String) {
        if let item = cache[name] {
            items = item.country
        } else {
            service.get(url(name: name))
                .decode(type: Response.self, decoder: JSONDecoder())
                .receive(on: DispatchQueue.main)
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

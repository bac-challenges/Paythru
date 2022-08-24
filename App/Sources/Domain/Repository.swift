//
//  Repository.swift
//  Paythru
//
//  Created by emile on 24/08/2022.
//

import Foundation
import Combine

protocol Repository {
    func get(name: String)
    var items: [Country] { get }
}

// MARK: -
final class RemoteRepository: Repository, ObservableObject {

    @Published
    public var items = [Country]()

    @Injected(\.service)
    private var service: Service
    private var cache = [String: Response]()

    @BundleBacked<String>(key: "api-url")
    private var baseurl

    private var cancelBag = CancelBag()

    init() {
        cache.load()
    }

    func get(name: String) {

        var components = URLComponents()
        components.scheme = "https"
        components.host = baseurl
        components.path = ""
        components.queryItems = [URLQueryItem(name: "name", value: name.lowercased())]

        guard let url = components.url else { fatalError("") }

        service.get(url)
            .decode(type: Response.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { error in
                print(error)
            } receiveValue: { [weak self] item in
                self?.items = item.country
            }
            .store(in: cancelBag)

    }
}

// MARK: - Injection
private struct RepositoryKey: InjectionKey {
    static var currentValue: Repository = RemoteRepository()
}

extension InjectedValues {
    var repository: Repository {
        get { Self[RepositoryKey.self] }
        set { Self[RepositoryKey.self] = newValue }
    }
}

//
//  Service.swift
//  Paythru
//
//  Created by emile on 24/08/2022.
//

import Foundation
import Combine

// MARK: - EndPoint
protocol EndPointProtocol {
    var url: URL? { get }
}

// MARK: - Service
protocol Service {
    func get(_ url: URL) -> AnyPublisher<Data, Error>
}

struct RemoteService: Service {
    func get(_ url: URL) -> AnyPublisher<Data, Error> {
        return URLSession.shared.dataTaskPublisher(for: url, cachedResponseOnError: true)
            .map(\.data)
            .eraseToAnyPublisher()
    }
}

struct LocalService: Service {
    func get(_ url: URL) -> AnyPublisher<Data, Error> {

        guard let data = try? Data(contentsOf: url) else {
            fatalError("BAD DATA")
        }

        return Future<Data, Error> { promise in
            promise(.success(data))
        }.eraseToAnyPublisher()
    }
}

// MARK: - Injection
private struct ServiceKey: InjectionKey {
    static var currentValue: Service = RemoteService()
}

extension InjectedValues {
    var service: Service {
        get { Self[ServiceKey.self] }
        set { Self[ServiceKey.self] = newValue }
    }
}

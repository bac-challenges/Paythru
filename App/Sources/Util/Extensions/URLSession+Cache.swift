//
//  URLSession+Cache.swift
//  Paythru
//
//  Created by emile on 24/08/2022.
//

import Foundation
import Combine

typealias ShortOutput = URLSession.DataTaskPublisher.Output

extension URLSession {
    func dataTaskPublisher(for url: URL, cachedResponseOnError: Bool) -> AnyPublisher<ShortOutput, Error> {
        return self.dataTaskPublisher(for: url)
            .tryCatch { [weak self] (error) -> AnyPublisher<ShortOutput, Never> in

                guard cachedResponseOnError,
                      let urlCache = self?.configuration.urlCache,
                      let cachedResponse = urlCache.cachedResponse(for: URLRequest(url: url))
                else {
                    throw error
                }

                return Just(ShortOutput(
                    data: cachedResponse.data,
                    response: cachedResponse.response
                )).eraseToAnyPublisher()

            }.eraseToAnyPublisher()
    }
}

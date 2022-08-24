//
//  Tests.swift
//  Tests
//
//  Created by emile on 24/08/2022.
//

import XCTest
@testable import Paythru

final class Tests: XCTestCase {

    @BundleBacked<String>(key: "test-key")
    private var bundleItem

    private var countries: [Country]!
    private var response: Response!
    private var cacheDict: [String: Response]!
    private var cancelBag: CancelBag!
    private var pubResult: String!
    private var viewModel: ViewModel!

    override func setUp() {
        super.setUp()

        countries = [Country(code: "GB", probability: 1.22)]
        response  = Response(name: "Emile", country: countries)
        cacheDict = ["Emile": response]
        cancelBag = CancelBag()
        pubResult = ""
        viewModel = ViewModel()
    }

    override func tearDown() {
        super.tearDown()

        countries = nil
        response  = nil
        cacheDict = nil
        cancelBag = nil
        pubResult = nil
        viewModel = nil
    }

    // MARK: - Bundle+Wrapper
    func testBundleBacked() {

        XCTAssertNotNil(bundleItem)

        guard let bundleItem = bundleItem else {
            XCTFail("Item not read.")
            return
        }

        XCTAssertEqual(bundleItem, "testme!!!")
    }

    // MARK: - Injection
    func testInjection() {
        @Injected(\.service)
        var service: Service

        XCTAssertNotNil(service)
    }

    // MARK: - Dictionary+Cache
    func testCache() {

        var cache = [String: Response]()

        XCTAssertNotEqual(cache, cacheDict)
        cache = cacheDict
        cache.save()
        XCTAssertEqual(cache, cacheDict)
        cache = [String: Response]()
        cache.save()
        XCTAssertNotEqual(cache, cacheDict)
    }

    // MARK: - String+Localization
    func testLocalization() {
        XCTAssertEqual("SEARCH".localized, "Search")
        XCTAssertEqual(~"SEARCH", "Search")
    }

    // MARK: - CancelBag
    func testCancelBag() {

        XCTAssertEqual(cancelBag.subscriptions.count, 0, "Test empty")

        "Publisher".publisher
            .sink { print("New value: \($0)") }
            .store(in: cancelBag)

        XCTAssertEqual(cancelBag.subscriptions.count, 1, "Test store(in:) +1")

        cancelBag.collect {
            "Publisher 1".publisher.sink { print("New value: \($0)") }
            "Publisher 2".publisher.sink { print("New value: \($0)") }
            "Publisher 3".publisher.sink { print("New value: \($0)") }
        }

        XCTAssertEqual(cancelBag.subscriptions.count, 4, "Test collect +3")

        cancelBag.cancel()
        XCTAssertEqual(cancelBag.subscriptions.count, 0, "Test cancel()")
    }

    // MARK: - ViewModel
    func testViewModel() {
        let expectation = XCTestExpectation(description: "State is set to populated")

        if let data = try? JSONEncoder().encode(response) {

            InjectedValues[\.service] = MockService(data: data)

            viewModel.$items
                .dropFirst()
                .sink {
                    XCTAssertEqual($0.count, 1)
                    XCTAssertNotNil($0.first)
                    expectation.fulfill()
                }
                .store(in: cancelBag)

            viewModel.search(name: "Emile")
        }

        wait(for: [expectation], timeout: 1)

        print(Response(name: "Emile", country: countries).hashValue)
        print(Response(name: "Emile", country: [Country(code: "GB", probability: 1.22)]).hashValue)
    }
}

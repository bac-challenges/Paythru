//
//  Bundle+Wrapper.swift
//  Paythru
//
//  Created by emile on 24/08/2022.
//

import Foundation

@propertyWrapper struct BundleBacked<Value> {
    let key: String
    var wrappedValue: Value? {
        Bundle.main.object(forInfoDictionaryKey: key) as? Value
    }
}

//
//  Dictionary+Cache.swift
//  Paythru
//
//  Created by emile on 24/08/2022.
//

import Foundation

extension Dictionary where Key == String, Value == Response {

    func save() {
        if let data = try? PropertyListEncoder().encode(self) {
            UserDefaults.standard.set(data, forKey: "local-cache")
            print("Cache saved.")
        }
    }

    mutating func load() {
        if let data = UserDefaults.standard.data(forKey: "local-cache"),
           let dict = try? PropertyListDecoder().decode([String: Response].self, from: data) {
            self = dict
        }
    }
}

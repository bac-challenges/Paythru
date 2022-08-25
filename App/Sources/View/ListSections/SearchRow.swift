//
//  SearchRow.swift
//  Paythru
//
//  Created by emile on 25/08/2022.
//

import SwiftUI

struct SearchRow: View {

    var item: Country

    var body: some View {
        VStack(alignment: .leading) {
            Text(~"COUNTRY" + ": \(item.code)").foregroundColor(.secondary)
            Text(String(format: ~"PROBABILITY", item.probability)).foregroundColor(.secondary)
        }
    }
}

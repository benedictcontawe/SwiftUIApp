//
//  NasaRequestModel.swift
//  SwiftUIApp
//
//  Created by Benedict Contawe on 8/15/24.
//

import Foundation

// Sent as the query string: ?api_key=...&count=5
struct NasaRequestModel: Encodable {
    let key: String
    let count: Int

    private enum CodingKeys: String, CodingKey {
        case key = "api_key"
        case count
    }

    /*
     Not needed: Swift generates this "memberwise" init for structs automatically.
     Uncomment only if you need custom logic (e.g. validation or default values).

    init(key: String, count: Int) {
        self.key = key
        self.count = count
    }
    */

    /*
     Not needed: Swift generates encode(to:) from `Encodable` + `CodingKeys` automatically.
     Uncomment only if the output must differ from the properties (e.g. skip or combine fields).

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(key, forKey: .key)
        try container.encode(count, forKey: .count)
    }
    */
}

// Like toString() in Kotlin/Java: controls what print(request) shows.
// The API key is masked so it never ends up in logs.
extension NasaRequestModel: CustomStringConvertible {
    var description: String {
        "NasaRequestModel(key: \(key.prefix(4))****, count: \(count))"
    }
}

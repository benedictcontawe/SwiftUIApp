//
//  NasaRequestModel.swift
//  SwiftUIApp
//
//  Created by Benedict Contawe on 8/15/24.
//

import Foundation

struct NasaRequestModel: Encodable {
    var key: String? = nil
    var count: Int? = nil

    private enum CodingKeys: String, CodingKey {
        case key = "api_key"
        case count = "count"
    }

    /*
     Not needed: Swift generates this "memberwise" init for structs automatically.
     Uncomment only if you need custom logic (e.g. validation or default values).

    init(key: String? = nil, count: Int? = nil) {
        self.key = key
        self.count = count
    }
    */

    /*
     Not needed: Swift generates encode(to:) from `Encodable` + `CodingKeys` automatically.
     Uncomment only if the output must differ from the properties (e.g. skip or combine fields).

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(key, forKey: .key)
        try container.encodeIfPresent(count, forKey: .count)
    }
    */
}

extension NasaRequestModel: CustomStringConvertible {
    private static let TAG = String(describing: NasaRequestModel.self)

    var description: String {
        "\(Self.TAG)(\(key ?? "null"), \(count.map(String.init) ?? "null"))"
    }
}

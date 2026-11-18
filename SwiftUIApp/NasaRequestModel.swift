//
//  NasaRequestModel.swift
//  SwiftUIApp
//
//  Created by Benedict Contawe on 8/15/24.
//

import Foundation

/// Mirrors `NasaRequestModel.kt`: same fields, same order, same JSON names.
/// Sent as the query string: ?api_key=...&count=10 (nil values are left out).
struct NasaRequestModel: Encodable {
    var key: String? = nil      // @SerializedName("api_key")
    var count: Int? = nil       // @SerializedName("count")

    // Like @SerializedName in Gson: Swift property name → JSON / query name
    private enum CodingKeys: String, CodingKey {
        case key = "api_key"
        case count = "count"
    }

    /*
     Not needed: Swift generates this "memberwise" init for structs automatically
     (with the `= nil` defaults, like Kotlin's default arguments).
     Uncomment only if you need custom logic (e.g. validation or default values).

    init(key: String? = nil, count: Int? = nil) {
        self.key = key
        self.count = count
    }
    */

    /*
     Not needed: Swift generates encode(to:) from `Encodable` + `CodingKeys` automatically.
     For optionals it uses encodeIfPresent, which skips nil values.
     Uncomment only if the output must differ from the properties (e.g. skip or combine fields).

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(key, forKey: .key)
        try container.encodeIfPresent(count, forKey: .count)
    }
    */
}

// Like `override fun toString()` in NasaRequestModel.kt: "$TAG($key, $count)"
extension NasaRequestModel: CustomStringConvertible {
    private static let TAG = String(describing: NasaRequestModel.self)

    var description: String {
        "\(Self.TAG)(\(key ?? "null"), \(count.map(String.init) ?? "null"))"
    }
}

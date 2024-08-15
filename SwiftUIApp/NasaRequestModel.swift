//
//  NasaRequestModel.swift
//  SwiftUIApp
//
//  Created by Benedict Contawe on 8/15/24.
//

import Foundation

public struct NasaRequestModel : Encodable, CustomStringConvertible {
    let key : String
    let count : Int
  
    private enum CodingKeys: String, CodingKey {
        case key = "api_key"
        case count
    }

    init(key: String, count: Int) {
        self.key = key
        self.count = count
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(key, forKey: .key)
        try container.encodeIfPresent(count, forKey: .count)
    }
    
    public var description : String {
        return "NasaRequestModel key \(key), count \(count)"
    }
}

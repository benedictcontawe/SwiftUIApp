//
//  PrimitiveModel.swift
//  SwiftUIApp
//
//  Created by Benedict Contawe on 11/28/24.
//

import Foundation

struct PrimitiveModel {
  let id: String?
  let data: Any?
  let type: String?

  init(id : String?, data : Any?, type : String?) {
    self.id = id
    self.data = data
    self.type = type
  }
    
    public func toMap() -> [String: Any] {
        var map: [String: Any] = [:]
        if let data = data {
            switch data {
            case let booleanValue as Bool:
                map[Constants.BOOLEAN] = booleanValue
            case let stringValue as String:
                map[Constants.STRING] = stringValue
            case let intValue as Int:
                map[Constants.INTEGER] = intValue
            case let doubleValue as Double:
                map[Constants.DOUBLE] = doubleValue
            default:
                // Handle other data types or unknown types
                break
            }
        }
        return map
    }
}

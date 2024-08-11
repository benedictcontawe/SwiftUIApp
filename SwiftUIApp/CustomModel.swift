//
//  CustomModel.swift
//  SwiftUIApp
//
//  Created by Benedict Contawe on 7/22/24.
//

import SwiftData
import SwiftUI

@Model
final class CustomModel : Identifiable, CustomStringConvertible {
    public let id : UUID = UUID()
    public var name : String
    
    init(name : String) {
        self.name = name
    }
    
    var description: String {
        return "CustomModel: name \(name)"
    }
}

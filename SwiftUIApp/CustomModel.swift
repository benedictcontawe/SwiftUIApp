//
//  CustomModel.swift
//  SwiftUIApp
//
//  Created by Benedict Contawe on 7/22/24.
//

import SwiftUI

struct CustomModel : Identifiable, CustomStringConvertible {
    let id : UUID = UUID()
    let name : String
    var description: String {
        return "CustomModel: name \(name)"
    }
}

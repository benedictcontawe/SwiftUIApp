//
//  DrawerModel.swift
//  SwiftUIApp
//
//  Created by Benedict Contawe on 7/23/24.
//

import SwiftUI

struct TabModel : Identifiable, CustomStringConvertible {
    let id : UUID = UUID()
    let text : String
    let image : String
    
    var description : String {
        return "TabModel: text \(text) image \(image)"
    }
}

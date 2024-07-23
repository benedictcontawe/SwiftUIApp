//
//  DrawerModel.swift
//  SwiftUIApp
//
//  Created by Benedict Contawe on 7/23/24.
//

import SwiftUI

struct DrawerModel : Identifiable, CustomStringConvertible {
    let id : UUID = UUID()
    let text : String
    let isHeader : Bool
    var isExpand : Bool
    let icon : String?
    
    var description : String {
        return "DrawerModel: text \(text) isHeader \(isHeader) isExpand \(isExpand)"
    }
}

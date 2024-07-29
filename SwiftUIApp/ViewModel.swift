//
//  ViewModel.swift
//  SwiftUIApp
//
//  Created by Benedict Contawe on 7/22/24.
//

import SwiftUI

class ViewModel : ObservableObject {
    @Published public var models : [TabModel]
    init() {
        models = [
            TabModel(text: "AAA", image: "phone.fill"),
            TabModel(text: "BBB", image: "person.2.fill"),
            TabModel(text: "CCC", image: "slider.horizontal.3")
        ]
    }
    
    deinit {
        
    }
}

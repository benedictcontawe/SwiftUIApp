//
//  ViewModel.swift
//  SwiftUIApp
//
//  Created by Benedict Contawe on 7/22/24.
//

import SwiftUI

class ViewModel : ObservableObject {
    @Published private var models : [CustomModel]
    @Published public var showAlert : Bool = false
    @Published public var showActionSheet : Bool = false
    @Published public var showSheet : Bool = false
    @Published public var addText : String = ""
    @Published public var editText : String = ""

    init() {
        models = [
            CustomModel(name: "AAA"),
            CustomModel(name: "BBB"),
            CustomModel(name: "CCC"),
            CustomModel(name: "DDD"),
            CustomModel(name: "EEE"),
            CustomModel(name: "FFF"),
            CustomModel(name: "GGG"),
            CustomModel(name: "HHH"),
            CustomModel(name: "III"),
            CustomModel(name: "JJJ"),
            CustomModel(name: "KKK"),
            CustomModel(name: "LLL"),
            CustomModel(name: "MMM"),
            CustomModel(name: "NNN"),
            CustomModel(name: "OOO"),
            CustomModel(name: "PPP"),
            CustomModel(name: "QQQ"),
            CustomModel(name: "RRR"),
            CustomModel(name: "SSS"),
            CustomModel(name: "TTT"),
            CustomModel(name: "UUU"),
            CustomModel(name: "VVV"),
            CustomModel(name: "WWW"),
            CustomModel(name: "XXX"),
            CustomModel(name: "YYY"),
            CustomModel(name: "ZZZ")
        ]
    }
    
    func addModel() {
        guard !addText.isEmpty else {
            print("Add text is empty")
            return
        }
        models.append(CustomModel(name: addText))
    }
    
    func shuffleModel() {
        models.shuffle()
    }
    
    func reverseModel() {
        models.reverse()
    }
    
    func clearModel(index: Int?) {
        guard let index = index, index >= 0, index < models.count else {
            print("Invalid index")
            return
        }
        models.remove(at: index)
    }
    
    func clearModel() {
        models.removeAll()
    }
    
    func getModels() -> [CustomModel] {
        return models
    }
    
    deinit {
        
    }
}

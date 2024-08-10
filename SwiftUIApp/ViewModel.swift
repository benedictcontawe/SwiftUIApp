//
//  ViewModel.swift
//  SwiftUIApp
//
//  Created by Benedict Contawe on 7/22/24.
//

import SwiftUI

class ViewModel : ObservableObject {
    @Published private var models : [CustomModel]
    @Published public var showAlert = false
    @Published public var showActionSheet = false
    @Published public var showSheet = false
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
    
    func shuffleModel() {
        models.shuffle()
    }
    
    func reverseModel() {
        models.reverse()
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

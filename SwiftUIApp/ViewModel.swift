//
//  ViewModel.swift
//  SwiftUIApp
//
//  Created by Benedict Contawe on 7/22/24.
//

import SwiftUI

class ViewModel : ObservableObject {
    @Published public var model : [CustomModel]
    @Published private var data : String
    @Published private var progressData : Float
    @Published var toggleState : Bool = true
    @Published var pickerState : Int = 0
    @Published var stepperState : Int = 5
    @Published var sliderState : Float = 5.0
    
    init() {
        model = []
        data = "Data"
        progressData = 0.0
    }
    
    func setData(data : String) {
        self.data = data
    }
    
    func getData() -> String {
        return self.data
    }
    
    func setProgressData(progressData : Float) {
        self.progressData = progressData
    }
    
    func getProgressData() -> Float {
        return self.progressData
    }
    
    func setSwitchChecked(isChecked : Bool) {
        if isChecked {
            setData(data: "Toggle is On")
        } else {
            setData(data: "Toggle is Off")
        }
    }
    
    func shuffleModel() {
        model.shuffle()
    }
    
    func reverseOrder() {
        model.reverse()
    }
    
    deinit {
        
    }
}

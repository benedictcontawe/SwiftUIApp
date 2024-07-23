//
//  ViewModel.swift
//  SwiftUIApp
//
//  Created by Benedict Contawe on 7/22/24.
//

import SwiftUI

class ViewModel : ObservableObject {
    @Published public var models : [DrawerModel]
    @Published private var data : String
    @Published private var progressData : Float
    @Published var toggleState : Bool = true
    @Published var pickerState : Int = 0
    @Published var stepperState : Int = 5
    @Published var sliderState : Float = 5.0
    
    init() {
        models = [
            DrawerModel(text: "AAA", isHeader: true, isExpand: true, icon: nil),
            DrawerModel(text: "BBB", isHeader: false, isExpand: true, icon: nil),
            DrawerModel(text: "CCC", isHeader: false, isExpand: true, icon: nil),
            DrawerModel(text: "DDD", isHeader: true, isExpand: true, icon: nil),
            DrawerModel(text: "EEE", isHeader: false, isExpand: true, icon: nil),
            DrawerModel(text: "FFF", isHeader: false, isExpand: true, icon: nil),
            DrawerModel(text: "GGG", isHeader: false, isExpand: true, icon: nil),
            DrawerModel(text: "HHH", isHeader: false, isExpand: true, icon: nil),
            DrawerModel(text: "III", isHeader: false, isExpand: true, icon: nil),
            DrawerModel(text: "JJJ", isHeader: false, isExpand: true, icon: nil),
            DrawerModel(text: "KKK", isHeader: false, isExpand: true, icon: nil),
            DrawerModel(text: "LLL", isHeader: false, isExpand: true, icon: nil),
            DrawerModel(text: "MMM", isHeader: false, isExpand: true, icon: nil),
            DrawerModel(text: "NNN", isHeader: false, isExpand: true, icon: nil),
            DrawerModel(text: "OOO", isHeader: false, isExpand: true, icon: nil),
            DrawerModel(text: "PPP", isHeader: false, isExpand: true, icon: nil),
            DrawerModel(text: "QQQ", isHeader: false, isExpand: true, icon: nil),
            DrawerModel(text: "RRR", isHeader: true, isExpand: true, icon: nil),
            DrawerModel(text: "SSS", isHeader: false, isExpand: true, icon: nil),
            DrawerModel(text: "TTT", isHeader: false, isExpand: true, icon: nil),
            DrawerModel(text: "UUU", isHeader: false, isExpand: true, icon: nil),
            DrawerModel(text: "VVV", isHeader: false, isExpand: true, icon: nil),
            DrawerModel(text: "WWW", isHeader: false, isExpand: true, icon: nil),
            DrawerModel(text: "XXX", isHeader: false, isExpand: true, icon: nil),
            DrawerModel(text: "YYY", isHeader: false, isExpand: true, icon: nil),
            DrawerModel(text: "ZZZ", isHeader: false, isExpand: true, icon: nil)
        ]
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
        models.shuffle()
    }
    
    func reverseOrder() {
        models.reverse()
    }
    
    deinit {
        
    }
}

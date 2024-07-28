//
//  ViewModel.swift
//  SwiftUIApp
//
//  Created by Benedict Contawe on 7/22/24.
//

import SwiftUI

class ViewModel : ObservableObject {
    @Published public var models : [DrawerModel]
    @Published public var showMenu = false
    @Published public var selectedPage: String = "Hello World"
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
    }
    
    public func onHeaderCellClick(position : Int, model : DrawerModel) {
        withAnimation {
            if model.isHeader && model.isExpand {
                setCompress(model : model, position : position)
            } else if model.isHeader && model.isExpand == false {
                setExpand(model : model, position : position)
            }
        }
    }
    
    private func setExpand(model : DrawerModel, position : Int) {
        //models[position] = model
        for index  in position ..< models.count {
            if models[index].isHeader && index != position {
                break
            } else if models[index].isHeader == false {
                models[index].isExpand = true
            } else {
                models[index].isExpand = true
            }
        }
    }
    
    private func setCompress(model : DrawerModel, position : Int) {
        models[position] = model
        for index  in position ..< models.count {
            if models[index].isHeader && index != position {
                break
            } else if models[index].isHeader == false {
                models[index].isExpand = false
            } else {
                models[index].isExpand = false
            }
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

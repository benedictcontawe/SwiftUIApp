//
//  ViewModel.swift
//  SwiftUIApp
//
//  Created by Benedict Contawe on 7/22/24.
//

import SwiftData
import SwiftUI

class ViewModel : ObservableObject {
    
    private let dataSource: SwiftDataService
    @Published private var models : [CustomModel] = []
    @Published public var selectedIndex : Int?
    @Published public var showClearAlert : Bool = false
    @Published public var showActionSheet : Bool = false
    @Published public var showAddSheet : Bool = false
    @Published public var showEditSheet : Bool = false
    @Published public var addText : String?
    @Published public var editText : String?

    init(dataSource: SwiftDataService) {
        self.dataSource = dataSource
        models = dataSource.fetchModels()
    }
    
    func addModel() {
        guard let text = addText, !text.isEmpty else {
            print("Add text is empty")
            return
        }
        let newModel = CustomModel(name: text)
        dataSource.addModel(newModel)
        addText = nil
        models = dataSource.fetchModels()
    }
    
    func editModel() {
        guard let index = selectedIndex, index >= 0, index < models.count, let text = editText, !text.isEmpty else {
            print("Invalid index, text is empty or out of bounds")
            return
        }
        models[index].name = text
        dataSource.save()
        selectedIndex = nil
        editText = nil
    }
    
    func setEditText() {
        guard let index = selectedIndex, index >= 0, index < models.count else {
            print("Invalid index")
            return
        }
        editText = models[index].name
        dataSource.save()
        models = dataSource.fetchModels()
    }
    
    func clearModel(index: Int?) {
        guard let index = index, index >= 0, index < models.count else {
            print("Invalid index")
            return
        }
        dataSource.deleteModel(models[index])
        models = dataSource.fetchModels()
    }
    
    func clearModel() {
        dataSource.deleteModels()
        models = dataSource.fetchModels()
    }
    
    func getModels() -> [CustomModel] {
        print("getModels \(models.count)")
        return models
    }
    
    deinit {
        
    }
}

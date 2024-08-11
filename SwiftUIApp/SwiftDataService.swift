//
//  SwiftDataService.swift
//  SwiftUIApp
//
//  Created by Benedict Contawe on 8/11/24.
//

import SwiftData

class SwiftDataService {
    private let modelContainer: ModelContainer
    private let modelContext: ModelContext
    
    @MainActor
    public static let shared = SwiftDataService()
    
    @MainActor
    private init() {// Change isStoredInMemoryOnly to false if you would like to see the data persistance after kill/exit the app
        self.modelContainer = try! ModelContainer(for: CustomModel.self, configurations: ModelConfiguration(isStoredInMemoryOnly: false))
        self.modelContext = modelContainer.mainContext
    }
    
    public func addModel(_ model : CustomModel) {
        modelContext.insert(model)
        save()
    }
    
    public func deleteModel(_ model : CustomModel) {
        modelContext.delete(model)
        save()
    }
    
    public func deleteModels() {
        for model in fetchModels() {
            modelContext.delete(model)
        }
        save()
    }
    
    public func fetchModels() -> [CustomModel] {
        do {
            return try modelContext.fetch(FetchDescriptor<CustomModel>())
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    public func save() {
        //try? modelContext.save()
        do {
            try modelContext.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}

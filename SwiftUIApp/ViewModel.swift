//
//  ViewModel.swift
//  SwiftUIApp
//
//  Created by Benedict Contawe on 7/22/24.
//

import SwiftUI
import Combine

internal final class ViewModel: ObservableObject {
    @Published public var models : [TabModel] = []
    private var cancellables : Set<AnyCancellable> = Set<AnyCancellable>()
    private let modelSubject : PassthroughSubject<TabModel, Never> = PassthroughSubject<TabModel, Never>()

    init() {
        let initialModels : [TabModel] = [
            TabModel(text: "AAA", image: "phone.fill"),
            TabModel(text: "BBB", image: "person.2.fill"),
            TabModel(text: "CCC", image: "slider.horizontal.3")
        ]
        modelSubject
            .delay(for: .seconds(2), scheduler: DispatchQueue.main)
            .sink { [weak self] model in
                self?.models.append(model)
            }
            .store(in: &cancellables)
        addModelsWithDelay(initialModels)
    }
    
    private func addModelsWithDelay(_ newModels: [TabModel]) {
        for (index, model) in newModels.enumerated() {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 2.0) {
                self.modelSubject.send(model)
            }
        }
    }
    
    deinit {
        cancellables.forEach { $0.cancel() }
    }
}

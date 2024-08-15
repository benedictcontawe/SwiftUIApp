//
//  ViewModel.swift
//  SwiftUIApp
//
//  Created by Benedict Contawe on 7/22/24.
//

import SwiftUI

public class ViewModel : ObservableObject {
    @Published public var models : [NasaResponseModel]
    @Published public var isLoading = false
    @Published public var errorMessage: String?
    private let networkManager = NetworkManager()
    
    init() {
        self.models = []
        Task {
            await requestAPOD()
        }
    }
    
    init(models: [NasaResponseModel], isLoading: Bool = false, errorMessage: String? = nil) {
        self.models = models
        self.isLoading = isLoading
        self.errorMessage = errorMessage
        Task {
            await requestAPOD()
        }
    }
    
    public func requestAPOD() async {
        isLoading = true
        let apiKey = "lebNOALEyzgIAKKggQws8YGcWVLDK72R0l2Twryx"
        let request : NasaRequestModel = NasaRequestModel (
            key: apiKey,
            count: 5
        )
        networkManager.getApod(request: request) { result in
          DispatchQueue.main.async {
            self.isLoading = false
            switch result {
            case .success(let response):
                withAnimation(.bouncy) {
                    self.models.insert(contentsOf: response, at: 0)
                }
            case .failure(let error):
              self.errorMessage = error.localizedDescription
            }
          }
        }
    }
    
    deinit {
        
    }
}

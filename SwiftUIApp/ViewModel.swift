//
//  ViewModel.swift
//  SwiftUIApp
//
//  Created by Benedict Contawe on 7/22/24.
//

import Foundation
import Observation

/// Mirrors `MainViewModel.kt`: just the repository and the paged data.
///
///     private val repository : Repository
///     private val pagingAPOD : Flow<PagingData<NasaHolderModel>>
///
/// - `@Observable` (iOS 17+): SwiftUI re-renders only the views that read a property that changed.
/// - `@MainActor`: every property change happens on the main thread, which UI state requires.
@MainActor
@Observable
final class ViewModel {
    private let repository: Repository
    let pagingAPOD: Pager<Int, NasaResponseModel>      // like Flow<PagingData<NasaResponseModel>>

    /// Like MainViewModel's constructor:
    ///
    ///     val request = NasaRequestModel(Constants.API_KEY, Constants.APPEND_COUNT)
    ///     pagingAPOD = repository.getFlowAPOD(request)...cachedIn(viewModelScope)
    ///
    /// Created once, so the loaded pages survive view updates (like `cachedIn(viewModelScope)`).
    /// The repository is injected: the app uses the real one, previews/tests pass one with a fake API.
    init(repository: Repository = Repository()) {
        self.repository = repository
        let request = NasaRequestModel(key: Constants.apiKey, count: Constants.appendCount)
        self.pagingAPOD = repository.getFlowAPOD(request: request)
    }

    deinit {

    }
}

//
//  ViewModel.swift
//  SwiftUIApp
//
//  Created by Benedict Contawe on 7/22/24.
//

import Foundation
import Observation

/// State and logic for the picture list. No SwiftUI import: the view model knows nothing
/// about views, which keeps it easy to unit test.
///
/// - `@Observable` (iOS 17+): SwiftUI re-renders only the views that read a property that changed.
///   Replaces `ObservableObject` + `@Published`.
/// - `@MainActor`: every property change happens on the main thread, which UI state requires.
@MainActor
@Observable
final class ViewModel {
    /// `private(set)`: views can read the list, only the view model can change it.
    private(set) var models: [NasaResponseModel] = []
    private(set) var isLoading = false
    var errorMessage: String?

    private let service: any APODServiceProtocol
    private let batchSize: Int

    /// The service is injected: the app uses the real network, previews/tests pass a mock.
    init(service: any APODServiceProtocol = NetworkManager(), batchSize: Int = 5) {
        self.service = service
        self.batchSize = batchSize
    }

    /// First load. Safe to call every time the screen appears.
    func loadIfNeeded() async {
        guard models.isEmpty else { return }
        await refresh()
    }

    /// Fetches a new batch of random pictures and puts them at the top of the list.
    /// `async` all the way, so `.refreshable` keeps its spinner until this returns.
    func refresh() async {
        guard !isLoading else { return }    // ignore a second pull while one is running
        isLoading = true
        defer { isLoading = false }         // always reset, whatever path we exit through
        
        do {
            let batch = try await service.fetchRandomPictures(count: batchSize)
            let knownIDs = Set(models.map(\.id))
            models.insert(contentsOf: batch.filter { !knownIDs.contains($0.id) }, at: 0)
            errorMessage = nil
        } catch is CancellationError {
            // The view went away mid-request; not an error worth showing.
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    deinit {
        
    }
}

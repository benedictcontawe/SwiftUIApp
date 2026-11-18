//
//  ContentView.swift
//  SwiftUIApp
//
//  Created by Benedict Contawe on 7/22/24.
//

import SwiftUI

/// Mirrors the `setContent { ... }` screen in `MainActivity.kt` (Compose_retrofit branch).
struct ContentView: View {
    /// `@State` owns an `@Observable` object for the lifetime of the view
    /// (like `by viewModels<MainViewModel>()`: the same ViewModel survives redraws).
    @State private var viewModel: ViewModel

    /// Injectable for previews; the app just calls `ContentView()`.
    /// `@MainActor` because it creates the main-actor `ViewModel`. The default is created in the
    /// body, not as `= ViewModel()` in the signature: default values aren't main-actor isolated.
    @MainActor
    init(viewModel: ViewModel? = nil) {
        _viewModel = State(initialValue: viewModel ?? ViewModel())
    }

    var body: some View {
        NavigationStack {
            List {
                // Like LazyColumn's items(items = list, key = { it.date })
                ForEach(viewModel.liveList, id: \.date) { model in
                    CardCell(model: model)
                }
            }
            .listStyle(.plain)
            .navigationTitle("Astronomy Pictures")
            .overlay {
                // First load: the list is empty, so show a spinner in the middle
                // (on Android the PullRefreshIndicator shows while isRefreshing).
                if viewModel.liveList.isEmpty && viewModel.isRefreshing {
                    ProgressView()
                }
            }
            .animation(.bouncy, value: viewModel.liveList)
            .refreshable { await viewModel.requestAPOD() }      // like pullRefresh(onRefresh = viewModel::requestAPOD)
            .task { await viewModel.requestAPODIfEmpty() }      // like onStart() { viewModel.requestAPODIfEmpty() }
        }
    }
}

// MARK: - Previews (use the mock API: instant, offline, no API quota)

#Preview("Loaded") {
    ContentView(viewModel: ViewModel(repository: Repository(nasaAPI: MockNasaAPI())))
}

#Preview("Error") {
    ContentView(viewModel: ViewModel(repository: Repository(nasaAPI: MockNasaAPI(error: URLError(.notConnectedToInternet)))))
}

//
//  ContentView.swift
//  SwiftUIApp
//
//  Created by Benedict Contawe on 7/22/24.
//

import SwiftUI

struct ContentView: View {
    /// `@State` owns an `@Observable` object for the lifetime of the view
    /// (the iOS 17 replacement for `@StateObject`).
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
            List(viewModel.models) { picture in      // rows identified by `picture.id`
                CardCell(picture: picture)
            }
            .listStyle(.plain)
            .navigationTitle("Astronomy Pictures")
            .overlay { emptyState }
            .animation(.bouncy, value: viewModel.models)
            .refreshable { await viewModel.refresh() }   // spinner stays until refresh() returns
            .task { await viewModel.loadIfNeeded() }     // runs once on appear, cancelled on disappear
            .alert("Couldn't refresh", isPresented: isShowingRefreshError) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(viewModel.errorMessage ?? "")
            }
        }
    }

    /// Full-screen states, shown only while there is nothing in the list.
    @ViewBuilder
    private var emptyState: some View {
        if viewModel.models.isEmpty {
            if viewModel.isLoading {
                ProgressView("Loading pictures…")
            } else if let message = viewModel.errorMessage {
                ContentUnavailableView {
                    Label("No Pictures", systemImage: "wifi.exclamationmark")
                } description: {
                    Text(message)
                } actions: {
                    Button("Try Again") {
                        Task { await viewModel.refresh() }
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
        }
    }

    /// A refresh failed while pictures are already on screen → show an alert instead.
    private var isShowingRefreshError: Binding<Bool> {
        Binding(
            get: { viewModel.errorMessage != nil && !viewModel.models.isEmpty },
            set: { isPresented in if !isPresented { viewModel.errorMessage = nil } }
        )
    }
}

// MARK: - Previews (use the mock service: instant, offline, no API quota)

#Preview("Loaded") {
    ContentView(viewModel: ViewModel(service: MockAPODService()))
}

#Preview("Error") {
    ContentView(viewModel: ViewModel(service: MockAPODService(error: URLError(.notConnectedToInternet))))
}

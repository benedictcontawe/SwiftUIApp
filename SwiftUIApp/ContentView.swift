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

    /// Like `val lazyPagingItems = viewModel.observeAPOD().collectAsLazyPagingItems()`
    private var pagingAPOD: Pager<Int, NasaResponseModel> { viewModel.pagingAPOD }

    var body: some View {
        NavigationStack {
            List {
                ForEach(pagingAPOD.items, id: \.date) { picture in      // lazyPagingItems[index]
                    CardCell(picture: picture)
                }
                if !pagingAPOD.endOfPaginationReached && !pagingAPOD.items.isEmpty {
                    loadMoreFooter // Pagination footer: when it scrolls into view, the next page loads
                }
            }
            .listStyle(.plain)
            .navigationTitle("Astronomy Pictures")
            .overlay { emptyState }
            .animation(.bouncy, value: pagingAPOD.items)
            .refreshable { await pagingAPOD.refresh() }   // like lazyPagingItems.refresh()
            .task { await pagingAPOD.loadIfNeeded() }     // first load when the screen appears
            .alert("Couldn't load pictures", isPresented: isShowingRefreshError) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(pagingAPOD.error?.localizedDescription ?? "")
            }
        }
    }

    /// Full-screen states, shown only while there is nothing in the list.
    @ViewBuilder
    private var emptyState: some View {
        if pagingAPOD.items.isEmpty {
            if pagingAPOD.isRefreshing {                                 // loadState.refresh is Loading
                ProgressView("Loading pictures…")
            } else if let error = pagingAPOD.error {                     // loadState.refresh is Error
                ContentUnavailableView {
                    Label("No Pictures", systemImage: "wifi.exclamationmark")
                } description: {
                    Text(error.localizedDescription)
                } actions: {
                    Button("Try Again") {
                        Task { await pagingAPOD.refresh() }              // lazyPagingItems.retry()
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
        }
    }

    /// Last row of the list. Like Paging 3's append `LoadState` footer:
    /// - spinner while the next page is loading
    /// - "Load More" button if the last attempt failed (tap to retry)
    private var loadMoreFooter: some View {
        HStack {
            Spacer()
            if pagingAPOD.isAppending {                                  // loadState.append is Loading
                ProgressView()
            } else {
                Button("Load More") {
                    Task { await pagingAPOD.loadNextPage() }
                }
            }
            Spacer()
        }
        .padding(.vertical, 8)
        .listRowSeparator(.hidden)
        // Starts loading when the footer scrolls into view.
        // Not `.task`: List removes off-screen rows, which would cancel `.task` and the request
        // mid-flight. A plain `Task { }` keeps loading even if the user scrolls back up.
        .onAppear {
            Task { await pagingAPOD.loadNextPage() }
        }
    }

    /// A refresh or next page failed while pictures are already on screen → show an alert.
    private var isShowingRefreshError: Binding<Bool> {
        Binding(
            get: { pagingAPOD.error != nil && !pagingAPOD.items.isEmpty },
            set: { isPresented in if !isPresented { pagingAPOD.dismissError() } }
        )
    }
}

// MARK: - Previews (use the mock service: instant, offline, no API quota)

#Preview("Loaded") {
    ContentView(viewModel: ViewModel(repository: Repository(nasaAPI: MockNasaAPI())))
}

#Preview("Error") {
    ContentView(viewModel: ViewModel(repository: Repository(nasaAPI: MockNasaAPI(error: URLError(.notConnectedToInternet)))))
}

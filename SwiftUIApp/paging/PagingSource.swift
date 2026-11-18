//
//  PagingSource.swift
//  SwiftUIApp
//
//  Created by Benedict Contawe on 11/18/26.
//

import Foundation

// A small, reusable version of Android's Paging 3 building blocks.
// write a new `XxxPagingSource: PagingSource` for each paged list.

/// Like Paging 3's `abstract class PagingSource<Key, Value>`.
///
///
/// `associatedtype` is Swift's version of a generic parameter on a protocol.
/// `<Key, Value>` after the name (primary associated types) lets you write
/// `any PagingSource<Int, NasaResponseModel>`, just like `PagingSource<Int, NasaResponseModel>` in Kotlin.
///
/// Conforming types implement these methods (no `override` keyword in Swift).
/// If one is missing, the compiler says the type "does not conform to protocol 'PagingSource'".
///
/// `Sendable`: safe to use from any thread. `load` runs in the background (like a suspend fun
/// on Dispatchers.IO) while the ViewModel lives on the main thread, so Swift requires it.
protocol PagingSource<Key, Value>: Sendable {
    associatedtype Key
    associatedtype Value

    /// Like `abstract suspend fun load(params: LoadParams<Key>): LoadResult<Key, Value>`
    /// `key` = params.key (nil on the first load), `loadSize` = params.loadSize
    func load(key: Key?, loadSize: Int) async -> LoadResult<Key, Value>

    /// Like `abstract fun getRefreshKey(state: PagingState<Key, Value>): Key?`
    func getRefreshKey() -> Key?
}

/// Like Paging 3's `sealed class LoadResult<Key, Value>`.
/// It lives outside the protocol because Swift protocols can't contain nested types.
enum LoadResult<Key, Value> {
    case page(data: [Value], prevKey: Key?, nextKey: Key?)    // LoadResult.Page
    case error(Error)                                         // LoadResult.Error
}

/// Like Paging 3's `PagingConfig` (only the settings this app uses).
struct PagingConfig {
    let pageSize: Int           // items per page after the first
    let initialLoadSize: Int    // items in the first page
}

/// Like Paging 3's `Pager` + `PagingData` + `LoadStates`, in one small class.
/// It keeps the loaded items and the loading/error/end states, and asks the `PagingSource`
/// for the next page. Generic, so every paged screen can reuse it:
///
///     let pagingAPOD = Pager(config: ..., pagingSource: NasaPagingSource(...))
///
/// `@Observable`: SwiftUI redraws whenever `items` or a state changes (like collecting the Flow).
/// `@MainActor`: all state changes happen on the main thread, which UI state requires.
/// `Value: Hashable`: lets the Pager skip items it already has (random APIs can repeat items).
@MainActor
@Observable
final class Pager<Key, Value: Hashable> {
    private(set) var items: [Value] = []         // the loaded items (PagingData)
    private(set) var isRefreshing = false        // loadState.refresh is LoadState.Loading
    private(set) var isAppending = false         // loadState.append is LoadState.Loading
    private(set) var error: Error?               // LoadState.Error
    var endOfPaginationReached: Bool { nextKey == nil }   // loadState.append.endOfPaginationReached

    private let config: PagingConfig
    private let pagingSource: any PagingSource<Key, Value>
    private var nextKey: Key?

    init(config: PagingConfig, pagingSource: any PagingSource<Key, Value>) {
        self.config = config
        self.pagingSource = pagingSource
        self.nextKey = pagingSource.getRefreshKey()
    }

    /// First load. Safe to call every time the screen appears
    /// (like the first load Paging starts when the Flow is collected).
    func loadIfNeeded() async {
        guard items.isEmpty else { return }
        await refresh()
    }

    /// Like `lazyPagingItems.refresh()`: throw away the list and load from the refresh key again.
    func refresh() async {
        guard !isRefreshing else { return }      // ignore a second pull while one is running
        isRefreshing = true
        defer { isRefreshing = false }           // always reset, whatever path we exit through

        let result = await pagingSource.load(key: pagingSource.getRefreshKey(), loadSize: config.initialLoadSize)
        switch result {
        case .page(let data, _, let nextKey):
            items = data
            self.nextKey = nextKey
            error = nil
        case .error(let error):
            show(error)
        }
    }

    /// Like Paging's APPEND: load the next page and add it to the bottom.
    /// Call it when the end of the list scrolls into view.
    func loadNextPage() async {
        guard !isRefreshing, !isAppending, let key = nextKey else { return }
        isAppending = true
        defer { isAppending = false }

        let result = await pagingSource.load(key: key, loadSize: config.pageSize)
        switch result {
        case .page(let data, _, let nextKey):
            let known = Set(items)
            items.append(contentsOf: data.filter { !known.contains($0) })
            self.nextKey = nextKey
            error = nil
        case .error(let error):
            show(error)
        }
    }

    /// Clears the error after the user has seen it (e.g. tapped OK on an alert).
    func dismissError() {
        error = nil
    }

    private func show(_ error: Error) {
        // The screen went away mid-request; not an error worth showing.
        guard !(error is CancellationError) else { return }
        self.error = error
    }
}

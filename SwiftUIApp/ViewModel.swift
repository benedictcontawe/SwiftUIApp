//
//  ViewModel.swift
//  SwiftUIApp
//
//  Created by Benedict Contawe on 7/22/24.
//

import Foundation
import Observation

/// - `@Observable` (iOS 17+): SwiftUI redraws when `liveList` or `isRefreshing` changes,
/// - `@MainActor`: every property change happens on the main thread, which UI state requires.
@MainActor
@Observable
final class ViewModel {
    private static let TAG = String(describing: ViewModel.self)

    private let repository: Repository
    private(set) var liveList: [NasaHolderModel] = []
    private(set) var isRefreshing = false

    init(repository: Repository = Repository()) {
        print("\(Self.TAG) constructor")
        self.repository = repository
    }

    /// Like `requestAPODIfEmpty()`: first load only. Does nothing once pictures are loaded
    /// (also retries if the first load failed).
    func requestAPODIfEmpty() async {
        if liveList.isEmpty {
            await requestAPOD()
        }
    }

    /// `async`, so `.refreshable` keeps its spinner until this returns.
    func requestAPOD() async {
        if isRefreshing {                       // Ignore a new pull while the previous request is still running.
            return
        }
        isRefreshing = true
        defer { isRefreshing = false }          // like `finally { isRefreshing.value = false }`

        do {
            let request = NasaRequestModel(key: Constants.apiKey, count: Constants.appendCount)
            let responseList = try await repository.getAPOD(request: request)
            print("\(Self.TAG) requestAPOD() size \(responseList.count)")

            let shownDates = Set(liveList.map(\.date))
            var seenDates = Set<String>()
            let newList = responseList
                .filter { !($0.date ?? "").trimmingCharacters(in: .whitespaces).isEmpty }   // date.isNullOrBlank().not()
                .filter { seenDates.insert($0.date ?? "").inserted }                       // distinctBy { it.date }
                .filter { !shownDates.contains($0.date ?? "") }                            // filterNot { it.date in shownDates }
                .map { NasaHolderModel(response: $0) }                                     // map { NasaHolderModel(it) }
                .reversed()                                                                // Newest on top
            liveList = newList + liveList
        } catch is CancellationError {
            print("\(Self.TAG) requestAPOD() CancellationError")
        } catch {                               // No internet, timeout, bad response, etc. Keep the current list.
            print("\(Self.TAG) requestAPOD() Exception \(error.localizedDescription)")
        }
    }

    deinit {

    }
}

//
//  NasaAPI.swift
//  SwiftUIApp
//
//  Created by Benedict Contawe on 11/18/24.
//

import Foundation

/// previews/tests use `MockNasaAPI` below.
/// `Sendable`: safe to use from any thread (the network call runs in the background).
protocol NasaAPI: Sendable {
    /// GET planetary/apod?api_key=...&count=... → `count` random pictures
    func getAstronomyPictureOfTheDay(key: String, count: Int) async throws -> [NasaResponseModel]
}

#if DEBUG
/// Fake NasaAPI for previews: `count` fake pictures with random dates, no network needed.
struct MockNasaAPI: NasaAPI {
    var error: Error? = nil

    func getAstronomyPictureOfTheDay(key: String, count: Int) async throws -> [NasaResponseModel] {
        try await Task.sleep(for: .milliseconds(500))   // so the loading spinner is visible
        if let error { throw error }

        return (0..<count).map { _ in
            let date = Date(timeIntervalSince1970: .random(in: 804_000_000...1_780_000_000))
                .formatted(.iso8601.year().month().day())
            return NasaResponseModel(title: "Sample picture", copyright: nil, date: date,
                                     hdurl: nil, explanation: "Fake data for previews.")
        }
    }
}
#endif

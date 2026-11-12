//
//  NetworkManager.swift
//  SwiftUIApp
//
//  Created by Benedict Contawe on 8/15/24.
//

import Alamofire
import Foundation

/// The view model depends on this protocol, so previews can use a fake service.
protocol APODServiceProtocol {
    func fetchRandomPictures(count: Int) async throws -> [NasaResponseModel]
}

struct NetworkManager: APODServiceProtocol {
    private let url = "https://api.nasa.gov/planetary/apod"
    private let apiKey = "lebNOALEyzgIAKKggQws8YGcWVLDK72R0l2Twryx"

    func fetchRandomPictures(count: Int) async throws -> [NasaResponseModel] {
        let parameters = NasaRequestModel(key: apiKey, count: count)
        return try await AF.request(url, parameters: parameters)
            .validate()
            .serializingDecodable([NasaResponseModel].self)
            .value
    }
}

#if DEBUG
/// Fake service for previews: no network needed.
struct MockAPODService: APODServiceProtocol {
    var error: Error? = nil

    func fetchRandomPictures(count: Int) async throws -> [NasaResponseModel] {
        if let error { throw error }
        return [
            NasaResponseModel(date: "2024-04-08", title: "Total Solar Eclipse",
                              explanation: "The Moon passes between Earth and the Sun.",
                              copyright: "Jane Astronomer", image: nil),
            NasaResponseModel(date: "2023-07-12", title: "Rho Ophiuchi",
                              explanation: "The closest star-forming region to Earth.",
                              copyright: nil, image: nil)
        ]
    }
}
#endif

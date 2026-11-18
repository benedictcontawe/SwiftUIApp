//
//  Repository.swift
//  SwiftUIApp
//
//  Created by Benedict Contawe on 11/18/24.
//

import Alamofire
import Foundation

final class Repository {
    private static let TAG = String(describing: Repository.self)

    /// A `static let` is created once, the first time it's used, and is thread-safe.
    private static let session: Session = provideSession()

    private let nasaAPI: any NasaAPI

    init(nasaAPI: (any NasaAPI)? = nil) {
        self.nasaAPI = nasaAPI ?? Self.createService()
    }

    private static func provideSession() -> Session {
        let configuration = URLSessionConfiguration.af.default
        // Apple has no separate connect/write timeouts. This one is "max time with no data",
        // the closest match to OkHttp's readTimeout.
        configuration.timeoutIntervalForRequest = Constants.readTimeout
        return Session(configuration: configuration)
    }

    private static func createService() -> any NasaAPI {
        AlamofireNasaAPI(session: session)
    }

    private struct AlamofireNasaAPI: NasaAPI {
        let session: Session

        func getAstronomyPictureOfTheDay(key: String, count: Int) async throws -> [NasaResponseModel] {
            // @GET(API_GET) + @Query("api_key") key + @Query("count") count
            let request = NasaRequestModel(key: key, count: count)
            do {
                return try await session.request("\(Constants.apiDomain)/\(Constants.apiGet)", parameters: request)
                    .validate()                                        // like response.isSuccessful()
                    .serializingDecodable([NasaResponseModel].self)    // like GsonConverterFactory
                    .value
            } catch let error as AFError where error.isExplicitlyCancelledError {
                // Alamofire reports a cancelled request as its own AFError.
                // Translate it to Swift's standard CancellationError, so callers don't need Alamofire.
                throw CancellationError()
            }
        }
    }

    func getAPOD(request: NasaRequestModel) async throws -> [NasaResponseModel] {
        let list = try await nasaAPI.getAstronomyPictureOfTheDay(key: request.key ?? "", count: request.count ?? 0)
        print("\(Self.TAG) getAPOD() size \(list.count)")
        return list
    }
}

//
//  Repository.swift
//  SwiftUIApp
//
//  Created by Benedict Contawe on 11/18/26.
//

import Alamofire
import Foundation


/// Like `Repository.kt`: the Repository HAS the APIs (composition), it doesn't BE one.
/// To add another API later: add `private let weatherAPI: any WeatherAPI`, an init parameter,
/// and a `createWeatherService()` + `AlamofireWeatherAPI`, the same way as NasaAPI below.
final class Repository {
    private static let TAG = String(describing: Repository.self)
    private static let session: Session = provideSession()
    private let nasaAPI: any NasaAPI

    init(nasaAPI: (any NasaAPI)? = nil) {
        self.nasaAPI = nasaAPI ?? Self.createService()
    }

    private static func provideSession() -> Session {
        let configuration = URLSessionConfiguration.af.default
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

    private func getPagingConfig() -> PagingConfig {
        PagingConfig(
            pageSize: Constants.pageSize,
            initialLoadSize: Constants.pageSize
        )
    }

    /// `@MainActor` because `Pager` holds UI state and lives on the main thread.
    @MainActor
    func getFlowAPOD(request: NasaRequestModel) -> Pager<Int, NasaResponseModel> {
        Pager(
            config: getPagingConfig(),
            pagingSource: NasaPagingSource(nasaAPI: nasaAPI, request: request)
        )
    }

    func getAPOD(request: NasaRequestModel) async -> [NasaResponseModel] {
        do {
            return try await nasaAPI.getAstronomyPictureOfTheDay(key: request.key ?? "", count: request.count ?? 0)
        } catch {
            print("\(Self.TAG) getAPOD error \(error.localizedDescription)")
            return []
        }
    }
}

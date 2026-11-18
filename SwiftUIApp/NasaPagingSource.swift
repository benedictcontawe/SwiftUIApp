//
//  NasaPagingSource.swift
//  SwiftUIApp
//
//  Created by Benedict Contawe on 11/18/26.
//

import Foundation

///
/// Knows how to load ONE page for a given key, and what the previous/next keys are.
/// It holds no list state; the ViewModel keeps the loaded pages (like Paging's `Pager` does on Android).
///
struct NasaPagingSource: PagingSource {
    private static let TAG = String(describing: NasaPagingSource.self)

    private let nasaAPI: any NasaAPI
    private let request: NasaRequestModel

    init(nasaAPI: any NasaAPI, request: NasaRequestModel) {
        self.nasaAPI = nasaAPI
        self.request = request
        print("\(Self.TAG) init \(request.key ?? "null") \(request.count.map(String.init) ?? "null")")
    }

    func load(key: Int?, loadSize: Int) async -> LoadResult<Int, NasaResponseModel> {
        do {
            let position = key ?? Constants.pagingSourcePageIndex

            // count= returns that many random days, so ask for exactly one page's worth each time
            // (loadSize comes from PagingConfig: initialLoadSize for the first page, pageSize after).
            let body = try await nasaAPI.getAstronomyPictureOfTheDay(key: request.key ?? "", count: loadSize)

            let prevKey = position == Constants.pagingSourcePageIndex ? nil : position - 1
            let nextKey = body.isEmpty ? nil : position + 1
            print("\(Self.TAG) load \(position) \(prevKey.map(String.init) ?? "null") \(nextKey.map(String.init) ?? "null") size \(body.count)")

            return .page(data: body, prevKey: prevKey, nextKey: nextKey)
        } catch {
            print("\(Self.TAG) Error \(error.localizedDescription)")
            return .error(error)
        }
    }

    func getRefreshKey() -> Int? {
        Constants.pagingSourcePageIndex
    }
}

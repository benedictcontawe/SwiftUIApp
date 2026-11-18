//
//  Constants.swift
//  SwiftUIApp
//
//  Created by Benedict Contawe on 11/18/26.
//

import Foundation

enum Constants {
    static let apiDomain = "https://api.nasa.gov"                     // API_DOMAIN
    static let apiGet = "planetary/apod"                              // API_GET
    static let apiKey = "lebNOALEyzgIAKKggQws8YGcWVLDK72R0l2Twryx"   // API_KEY
    static let appendCount = 5                                        // APPEND_COUNT
    static let readTimeout: TimeInterval = 30                         // READ_TIMEOUT (seconds; count= can be slow)
    static let pageSize = 10                                          // PagingConfig(pageSize = 10)
    static let pagingSourcePageIndex = 1                              // PAGING_SOURCE_PAGE_INDEX
}

//
//  Constants.swift
//  SwiftUIApp
//
//  Created by Benedict Contawe on 11/18/24.
//

import Foundation

/// Mirrors `Constants.kt` (same names, Swift camelCase).
///
/// An `enum` with no cases is the Swift way to make a namespace, like a Kotlin `object`:
/// it can't be created by accident (`Constants()` doesn't compile), it only holds `static` values.
enum Constants {
    static let apiDomain = "https://api.nasa.gov"                     // API_DOMAIN
    static let apiGet = "planetary/apod"                              // API_GET
    static let apiKey = "lebNOALEyzgIAKKggQws8YGcWVLDK72R0l2Twryx"   // API_KEY
    static let appendCount = 5                                        // APPEND_COUNT
    static let readTimeout: TimeInterval = 30                         // READ_TIMEOUT (seconds; count= can be slow)
    static let blank = " "                                            // BLANK
}

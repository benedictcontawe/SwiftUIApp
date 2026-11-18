//
//  NasaResponseModel.swift
//  SwiftUIApp
//
//  Created by Benedict Contawe on 8/15/24.
//

import Foundation

struct NasaResponseModel: Decodable, Hashable {
    var title: String? = nil
    var copyright: String? = nil
    var date: String? = nil
    var hdurl: String? = nil
    var explanation: String? = nil

    // Like @SerializedName in Gson: Swift property name → JSON name
    private enum CodingKeys: String, CodingKey {
        case title = "title"
        case copyright = "copyright"
        case date = "date"
        case hdurl = "hdurl"
        case explanation = "explanation"
    }

    /*
     Not needed: because the struct says `Hashable`, Swift generates `==` and `hash(into:)`
     automatically, using ALL stored properties (like a Kotlin data class's equals/hashCode).
     This is what Swift generates for you:

    static func == (lhs: NasaResponseModel, rhs: NasaResponseModel) -> Bool {
        lhs.title == rhs.title &&
        lhs.copyright == rhs.copyright &&
        lhs.date == rhs.date &&
        lhs.hdurl == rhs.hdurl &&
        lhs.explanation == rhs.explanation
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
        hasher.combine(copyright)
        hasher.combine(date)
        hasher.combine(hdurl)
        hasher.combine(explanation)
    }

     If you ever need a custom version, compare by something unique (the date),
     never by `title` (the API returns "NASA Science" for many entries).
     `==` and `hash` must always use the same fields:

    static func == (lhs: NasaResponseModel, rhs: NasaResponseModel) -> Bool {
        lhs.date == rhs.date
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(date)
    }
    */
}

extension NasaResponseModel: CustomStringConvertible {
    private static let TAG = String(describing: NasaResponseModel.self)

    var description: String {
        "\(Self.TAG)(\(title ?? "null"), \(copyright ?? "null"), \(date ?? "null"), \(hdurl ?? "null"), \(explanation ?? "null"))"
    }
}

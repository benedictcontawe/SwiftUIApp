//
//  NasaResponseModel.swift
//  SwiftUIApp
//
//  Created by Benedict Contawe on 8/15/24.
//

import Foundation

struct NasaResponseModel: Decodable, Identifiable, Hashable {
    let date: String
    let title: String?
    let explanation: String?
    let copyright: String?
    let image: String?

    // One picture per date, so the date is a unique id for the List
    var id: String { date }

    private enum CodingKeys: String, CodingKey {
        case date, title, explanation, copyright
        case image = "hdurl"
    }

    /*
     Not needed: because the struct says `Hashable`, Swift generates `==` and `hash(into:)`
     automatically, using ALL stored properties (like a Kotlin data class's equals/hashCode).
     This is what Swift generates for you:

    static func == (lhs: NasaResponseModel, rhs: NasaResponseModel) -> Bool {
        lhs.date == rhs.date &&
        lhs.title == rhs.title &&
        lhs.explanation == rhs.explanation &&
        lhs.copyright == rhs.copyright &&
        lhs.image == rhs.image
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(date)
        hasher.combine(title)
        hasher.combine(explanation)
        hasher.combine(copyright)
        hasher.combine(image)
    }

     If you ever need a custom version, compare by something unique (the date / id),
     never by `title` (the API returns "NASA Science" for many entries).
     `==` and `hash` must always use the same fields:

    static func == (lhs: NasaResponseModel, rhs: NasaResponseModel) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    */
}

// Like toString() in Kotlin/Java: controls what print(model) shows.
// Long text is shortened to keep console logs readable.
extension NasaResponseModel: CustomStringConvertible {
    var description: String {
        "NasaResponseModel(date: \(date), title: \(title ?? "nil"), "
        + "copyright: \(copyright ?? "nil"), image: \(image ?? "nil"), "
        + "explanation: \((explanation ?? "nil").prefix(40))…)"
    }
}

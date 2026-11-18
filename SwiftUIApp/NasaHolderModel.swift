//
//  NasaHolderModel.swift
//  SwiftUIApp
//
//  Created by Benedict Contawe on 11/18/24.
//

import Foundation

struct NasaHolderModel: Hashable {
    let title: String
    let copyright: String
    let date: String            // Unique identifier: APOD has exactly one picture per day (used as the List key)
    let explanation: String
    let image: String

    init(response: NasaResponseModel) {
        title = response.title ?? Constants.blank
        copyright = response.copyright ?? Constants.blank
        date = response.date ?? Constants.blank
        explanation = response.explanation ?? Constants.blank
        image = response.hdurl ?? Constants.blank
    }
}

extension NasaHolderModel: CustomStringConvertible {
    private static let TAG = String(describing: NasaHolderModel.self)

    var description: String {
        "\(Self.TAG)(\(date), \(title), \(copyright), \(explanation), \(image))"
    }
}

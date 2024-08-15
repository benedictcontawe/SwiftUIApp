//
//  NasaResponseModel.swift
//  SwiftUIApp
//
//  Created by Benedict Contawe on 8/15/24.
//

import Foundation

public struct NasaResponseModel : Decodable, Hashable, CustomStringConvertible {
    let title : String?
    let copyright : String?
    let date : String?
    let image : String?
    let explanation : String?
    
    private enum CodingKeys: String, CodingKey {
        case title
        case copyright
        case date
        case image = "hdurl"
        case explanation
    }
    
    public func hash(into hasher: inout Hasher) {
            hasher.combine(title) // or any other unique property
        }

    public static func == (lhs: NasaResponseModel, rhs: NasaResponseModel) -> Bool {
        return lhs.title == rhs.title // or compare other properties as needed
    }


    public var description : String {
        return "NasaResponseModel title \(title ?? "Nil"), copyright \(copyright ?? "Nil"), date \(date ?? "Nil"), hdurl \(image ?? "Nil"), explanation \(explanation ?? "Nil")"
    }
}

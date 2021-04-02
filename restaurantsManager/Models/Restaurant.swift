//
//  Restaurants.swift
//  restaurantsManager
//
//  Created by developer on 12.03.2021.
//

import Foundation

struct Restaurant: Codable {
    let address: String?
    let description: String?
    let id: Int
    let imagePaths: [String]?
    let location: Location?
    let name: String?
    let rating: Float?
}

struct Location: Codable {
    let lat: Float?
    let lon: Float?
}

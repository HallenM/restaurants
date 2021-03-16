//
//  Restaurants.swift
//  restaurantsManager
//
//  Created by developer on 12.03.2021.
//

import Foundation

struct Restaurant: Decodable {
    let id: Int
    let name: String?
    let description: String?
    let address: String?
    let location: Location?
    let imagePath: [String]?
    let raiting: Float?
}

struct Location: Codable {
    let lan: Float?
    let lon: Float?
}

struct RestaurantsData: Decodable {
    let restaurants: [Restaurant]
}

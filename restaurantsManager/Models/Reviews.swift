//
//  Reviews.swift
//  restaurantsManager
//
//  Created by developer on 12.03.2021.
//

import Foundation

struct Review: Codable {
    let restaurantId: Int
    let author: String?
    let reviewText: String?
    let date: String?
}

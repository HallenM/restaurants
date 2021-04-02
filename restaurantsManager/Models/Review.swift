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
    let date: Date?
    
    init(restaurantId: Int, author: String, reviewText: String, date: Date){
        self.restaurantId = restaurantId
        self.author = author
        self.reviewText = reviewText
        self.date = date
    }
    
    init(from decoder: Decoder ) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        restaurantId = try values.decode(Int.self, forKey: .restaurantId)
        author = try values.decode(String.self, forKey: .author)
        reviewText = try values.decode(String.self, forKey: .reviewText)
        
        do {
            date = try values.decode(Date.self, forKey: .date)
        } catch {
            date = Date()
        }
    }
}

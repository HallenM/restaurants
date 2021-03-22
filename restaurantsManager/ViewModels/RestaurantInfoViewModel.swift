//
//  RestaurantInfoViewModel.swift
//  restaurantsManager
//
//  Created by developer on 12.03.2021.
//

import Foundation

class RestaurantInfoViewModel {
    private let restaurant: Restaurant
    
    init(restaurant: Restaurant) {
        self.restaurant = restaurant
    }
    
    func getName() -> String {
        return restaurant.name ?? ""
    }
    
    func getMainImage() -> String {
        return restaurant.imagePaths?[0] ?? ""
    }
    
    func getDescription() -> String {
        return restaurant.description ?? ""
    }
    
    func getImages() -> [String] {
        guard var array = restaurant.imagePaths else { return [String]() }
        array.remove(at: 0)
        return array
    }
    
    func getImagesCount() -> Int {
        guard var array = restaurant.imagePaths else { return 6 }
        array.remove(at: 0)
        return array.count
    }
    
    func getAddress() -> String {
        return restaurant.address ?? ""
    }
    
    func getLocation() -> Location {
        return restaurant.location ?? Location(lat: 0.0, lon: 0.0)
    }
    
    func getRating() -> Float {
        return restaurant.rating ?? 0.0
    }
}

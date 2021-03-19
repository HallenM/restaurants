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
    
    func getImage() -> [String] {
        guard var array = restaurant.imagePaths else { return [String]() }
        array.remove(at: 0)
        return array
    }
    
    func getAddress() -> String {
        return restaurant.address ?? ""
    }
}

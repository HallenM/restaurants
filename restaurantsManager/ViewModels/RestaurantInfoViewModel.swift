//
//  RestaurantInfoViewModel.swift
//  restaurantsManager
//
//  Created by developer on 12.03.2021.
//

import Foundation

protocol RestaurantInfoViewDelegateProtocol: class {
    
}

class RestaurantInfoViewModel {
    
    weak var viewDelegate: RestaurantInfoViewDelegateProtocol?
    
    private let restaurant: Restaurant
    
    private var reviews = [Review]()
    
    private let networkService: ReviewNetworkService = ReviewNetworkService()
    
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
    
    func getImage(index: Int) -> String {
        if getImagesCount() > index {
            return restaurant.imagePaths?[index] ?? ""
        }
        return ""
    }
    
    func getImagesCount() -> Int {
        return restaurant.imagePaths?.count ?? 6
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

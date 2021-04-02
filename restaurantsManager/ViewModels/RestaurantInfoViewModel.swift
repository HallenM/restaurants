//
//  RestaurantInfoViewModel.swift
//  restaurantsManager
//
//  Created by developer on 12.03.2021.
//

import UIKit

protocol RestaurantInfoViewDelegateProtocol: class {
    func showModalWindow()
    func insertCell(index: Int)
}

protocol NewReviewDelegateProtocol: class {
    func addNewReview(review: Review)
}

class RestaurantInfoViewModel {
    
    weak var viewDelegate: RestaurantInfoViewDelegateProtocol?
    
    private let restaurant: Restaurant
    
    private var reviews = [Review]()
    
    private let networkService: ReviewsNetworkService = ReviewsNetworkService()
    
    init(restaurant: Restaurant) {
        self.restaurant = restaurant
    }
    
    func initReviews(completion: @escaping () -> Void) {
        getReviewsForTable(completion: completion)
    }
    
    func getReviewsForTable(completion: @escaping () -> Void) {
        self.networkService.getReviewsForRestaurant(restaurantId: restaurant.id, completion: { (result) in
            switch result {
            case .success(let reviews):
                self.reviews = reviews
            case .failure(let error):
                print("ReviewsNetworkService Error: \(error)")
                self.reviews = [Review]()
                return
            }
            completion()
        })
    }
    
    func addRestaurantToStorage() {
        let defaults = UserDefaults.standard
        if let data = defaults.value(forKey: "SavedRestaurants") as? Data {
            if var array = try? PropertyListDecoder().decode([Restaurant].self, from: data) {
                array.append(restaurant)
                
                if let savedArray = try? PropertyListEncoder().encode(array) {
                    defaults.set(savedArray, forKey: "SavedRestaurants")
                }
            }
        } else {
            var array = [Restaurant]()
            array.append(restaurant)
            
            if let savedArray = try? PropertyListEncoder().encode(array) {
                defaults.set(savedArray, forKey: "SavedRestaurants")
            }
        }
    }
    
    func delRestaurantfromStorage() {
        let defaults = UserDefaults.standard
        if let data = defaults.value(forKey: "SavedRestaurants") as? Data {
            if var array = try? PropertyListDecoder().decode([Restaurant].self, from: data) {
                // Searching equal structures
                for i in 0..<array.count {
                    if equalValues(item: array[i]) {
                        array.remove(at: i)
                        break
                    }
                }
                
                if let savedArray = try? PropertyListEncoder().encode(array) {
                    defaults.set(savedArray, forKey: "SavedRestaurants")
                }
            }
        } else {
            let array = [Restaurant]()
            
            if let savedArray = try? PropertyListEncoder().encode(array) {
                defaults.set(savedArray, forKey: "SavedRestaurants")
            }
        }
    }
    
    func equalValues(item: Restaurant) -> Bool {
        if item.address == restaurant.address {
            if item.description == restaurant.description {
                if item.id == restaurant.id {
                    if item.imagePaths == restaurant.imagePaths {
                        if item.location?.lat == restaurant.location?.lat {
                            if item.location?.lon == restaurant.location?.lon {
                                if item.name == restaurant.name {
                                    if item.rating == restaurant.rating {
                                        return true
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        return false
    }
    
    func checkingFavouritesList() -> Bool {
        let defaults = UserDefaults.standard
        if let data = defaults.value(forKey: "SavedRestaurants") as? Data {
            if let array = try? PropertyListDecoder().decode([Restaurant].self, from: data) {
                // Searching equal structures
                for i in 0..<array.count {
                    if equalValues(item: array[i]) {
                        return true
                    }
                }
            }
        }
        return false
    }
    
    func getReview(index: Int) -> Review {
        return reviews[index]
    }
    
    func getReviewsCount() -> Int {
        return reviews.count
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
    
    func getRestaurantID() -> Int {
        return reviews[0].restaurantId
    }
    
    func didTapButton() {
        viewDelegate?.showModalWindow()
    }
}

extension RestaurantInfoViewModel: NewReviewDelegateProtocol {
    func addNewReview(review: Review) {
        reviews.insert(review, at: 0)
        viewDelegate?.insertCell(index: 0)
    }
}

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
                print("RviewsNetworkService Error: \(error)")
                self.reviews = [Review]()
                return
            }
            completion()
        })
    }
    
    func getReview(index: Int) -> Review {
        return reviews[index]
    }
    
    func getRviewsCount() -> Int {
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

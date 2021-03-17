//
//  ListRestaurantsViewModel.swift
//  restaurantsManager
//
//  Created by developer on 12.03.2021.
//

import Foundation

protocol RestaurantsListViewDelegateProtocol: class {
    
}

class RestaurantsListViewModel {
    
    weak var viewDelegate: RestaurantsListViewDelegateProtocol?
    
    weak var actionDelegate: RestaurantsListCoordinatorDelegateProtocol?
    
    private var restaurantsList = [Restaurant]()
    
    private let networkService: RestaurantsNetworkService = RestaurantsNetworkService()
    
    func initData(completion: @escaping () -> Void) {
        getDataForTable(completion: completion)
    }
    
    func getDataForTable(completion: @escaping () -> Void) {
        self.networkService.getRestaurantsList { (result) in
            switch result {
            case .success(let restaurants):
                self.restaurantsList = restaurants
            case .failure(_):
                self.restaurantsList = [Restaurant]()
                return
            }
            completion()
        }
    }
    
    func getRestaurantsCount() -> Int {
        return restaurantsList.count
    }
    
    func getRestaurantImage(index: Int) -> String {
        return restaurantsList[index].imagePaths?[0] ?? ""
    }
    
    func getRestaurantName(index: Int) -> String {
        return restaurantsList[index].name ?? ""
    }
    
    func getRestaurantDescription(index: Int) -> String {
        return restaurantsList[index].description ?? ""
    }
}

//
//  MapViewModel.swift
//  restaurantsManager
//
//  Created by developer on 12.03.2021.
//

import Foundation
import RealmSwift

protocol MapViewDelegateProtocol: class {
    
}

class MapViewModel {
    
    weak var viewDelegate: MapViewDelegateProtocol?
    
    weak var actionDelegate: RestaurantCoordinatorDelegateProtocol?
    
    private var restaurantsList = [Restaurant]()
    
    private let networkService: RestaurantsNetworkService
    
    init(networkService: RestaurantsNetworkService) {
        self.networkService = networkService
    }
    
    func initData(haveInternet: Bool, completion: @escaping () -> Void) {
        if haveInternet {
            getDataForTable(completion: completion)
        } else {
            getSavedDataForTable(completion: completion)
        }
    }
    
    func getDataForTable(completion: @escaping () -> Void) {
        self.networkService.getRestaurantsList { (result) in
            switch result {
            case .success(let restaurants):
                self.restaurantsList = restaurants
            case .failure(let error):
                print("RestaurantsNetworkService Error: \(error)")
                self.restaurantsList = [Restaurant]()
                return
            }
            completion()
        }
    }
    
    func getSavedDataForTable(completion: @escaping () -> Void) {
        let defaults = UserDefaults.standard
        if let data = defaults.value(forKey: "SavedRestaurants") as? Data {
            if let array = try? PropertyListDecoder().decode([Restaurant].self, from: data) {
                self.restaurantsList = array
            }
        } else {
            let array = [Restaurant]()
            self.restaurantsList = array
        }
        completion()
    }
    
    func getRestaurant(index: Int) -> Restaurant {
        return restaurantsList[index]
    }
    
    func getRestaurantsCount() -> Int {
        return restaurantsList.count
    }
    
    func getRestaurantLocation(index: Int) -> Location {
        return restaurantsList[index].location ?? Location(lat: 0.0, lon: 0.0)
    }
    
    func getRestaurantImage(index: Int) -> String {
        return restaurantsList[index].imagePaths?[0] ?? ""
    }
    
    func getRestaurantName(index: Int) -> String {
        return restaurantsList[index].name ?? ""
    }
    
    func getRestaurantAddress(index: Int) -> String {
        return restaurantsList[index].address ?? ""
    }
    
    func findRestaurantIndex(name: String) -> Int {
        for i in 0..<restaurantsList.count {
            if restaurantsList[i].name == name {
                return i
            }
        }
        return 0
    }
    
    func tapInfoButton(name: String) {
        let index = findRestaurantIndex(name: name)
        let restaurant = getRestaurant(index: index)
        actionDelegate?.showRestaurantInfo(restaurant: restaurant)
    }
}

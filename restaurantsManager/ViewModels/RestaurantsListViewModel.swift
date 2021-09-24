//
//  ListRestaurantsViewModel.swift
//  restaurantsManager
//
//  Created by developer on 12.03.2021.
//

import Foundation
import RealmSwift

protocol RestaurantsListViewDelegateProtocol: class {
    
}

class RestaurantsListViewModel {
    
    weak var viewDelegate: RestaurantsListViewDelegateProtocol?
    
    weak var actionDelegate: RestaurantCoordinatorDelegateProtocol?
    
    private var restaurantsList = [Restaurant]()
    
    private var allRestaurants = [Restaurant]()
    
    private let networkService: RestaurantsNetworkService
    
    private var realm: Realm!
    
    private var realmData: Results<RestaurantRealm> {
        get {
            return realm.objects(RestaurantRealm.self)
        }
    }
    
    init(networkService: RestaurantsNetworkService) {
        self.networkService = networkService
    }
    
    func initData(completion: @escaping (_ isSuccess: Bool) -> Void) {
        realm = try? Realm()
        
        getDataForTable(completion: completion)
    }
    
    func getDataForTable(completion: @escaping (_ isSuccess: Bool) -> Void) {
        self.networkService.getRestaurantsList { (result) in
            switch result {
            case .success(let restaurants):
                self.restaurantsList = restaurants
                self.allRestaurants = restaurants
                completion(true)
            case .failure(let error):
                print("RestaurantsNetworkService Error: \(error)")
                self.restaurantsList = [Restaurant]()
                self.allRestaurants = [Restaurant]()
                completion(false)
            }
        }
    }
    
    func getSavedDataForTable(completion: @escaping () -> Void) {
//        let defaults = UserDefaults.standard
//        if let data = defaults.value(forKey: "SavedRestaurants") as? Data {
//            if let array = try? PropertyListDecoder().decode([Restaurant].self, from: data) {
//                self.restaurantsList = array
//                self.allRestaurants = array
//            }
//        } else {
//            let array = [Restaurant]()
//            self.restaurantsList = array
//            self.allRestaurants = array
//        }
        self.restaurantsList = []
        self.allRestaurants = []
        for realItem in realmData {
            let item = realItem.objectToStructure()
            self.restaurantsList.append(item)
            self.allRestaurants.append(item)
        }
        completion()
    }
    
    func getRestaurant(index: Int) -> Restaurant {
        return restaurantsList[index]
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
    
    func didTapOnCell(with index: Int) {
        let restaurant = getRestaurant(index: index)
        actionDelegate?.showRestaurantInfo(restaurant: restaurant)
    }
    
    func searchRestaurants(searchText: String, completion: @escaping () -> Void) {
        var restaurants = [Restaurant]()
        restaurantsList = allRestaurants
        
        if searchText != "" {
            for restaurant in restaurantsList {
                let regex = NSRegularExpression("[a-z0-9-]*\(searchText)[a-z0-9-]*", options: .caseInsensitive)
                if regex.matches(restaurant.name ?? "") {
                    restaurants.append(restaurant)
                    if restaurants.count > 0 {
                        restaurantsList = restaurants
                    }
                }
            }
        } else {
            restaurantsList = allRestaurants
        }
        completion()
    }
}

extension NSRegularExpression {
    convenience init(_ pattern: String, options: NSRegularExpression.Options) {
        do {
            try self.init(pattern: pattern, options: options)
        } catch {
            preconditionFailure("Illegal regular expression: \(pattern).")
        }
    }
    
    func matches(_ string: String) -> Bool {
            let range = NSRange(location: 0, length: string.utf16.count)
            return firstMatch(in: string, options: [], range: range) != nil
        }
}

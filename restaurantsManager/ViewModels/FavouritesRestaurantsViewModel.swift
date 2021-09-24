//
//  FavouritesRestaurantsViewModel.swift
//  restaurantsManager
//
//  Created by Moshkina on 03.06.2021.
//

import Foundation
import RealmSwift

protocol FavouritesRestaurantsViewDelegateProtocol: class {

}

class FavouritesRestaurantsViewModel {

    weak var viewDelegate: FavouritesRestaurantsViewDelegateProtocol?
    
    weak var actionDelegate: RestaurantCoordinatorDelegateProtocol?
    
    private var favRestaurantsList = [Restaurant]()
    
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
    
    func initData(completion: @escaping () -> Void) {
        realm = try? Realm()
        
        getSavedDataForTable(completion: completion)
    }
    
    func getSavedDataForTable(completion: @escaping () -> Void) {
        favRestaurantsList = []
        for realItem in realmData {
            let item = realItem.objectToStructure()
            self.favRestaurantsList.append(item)
        }
        completion()
    }
    
    func getRestaurant(index: Int) -> Restaurant {
        return favRestaurantsList[index]
    }
    
    func getRestaurantsCount() -> Int {
        return favRestaurantsList.count
    }
    
    func getRestaurantImage(index: Int) -> String {
        return favRestaurantsList[index].imagePaths?[0] ?? ""
    }
    
    func getRestaurantName(index: Int) -> String {
        return favRestaurantsList[index].name ?? ""
    }
    
    func getRestaurantDescription(index: Int) -> String {
        return favRestaurantsList[index].description ?? ""
    }
    
    func didTapOnCell(with index: Int) {
        let restaurant = getRestaurant(index: index)
        actionDelegate?.showRestaurantInfo(restaurant: restaurant)
    }
}

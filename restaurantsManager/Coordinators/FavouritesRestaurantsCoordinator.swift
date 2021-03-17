//
//  FavouritesRestaurantCoordinator.swift
//  restaurantsManager
//
//  Created by developer on 12.03.2021.
//

import UIKit

protocol FavRestaurantsCoordDelegateProtocol: class {
    func showRestaurantInfo()
}

class FavouritesRestaurantsCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController?
    
    private var favouritesRestaurantsVM: FavouritesRestaurantsViewModel?
    private var restaurantInfoVM: RestaurantInfoViewModel?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let favouritesRestaurantsVC = storyboard
                .instantiateViewController(identifier: "FavouritesRestaurantsViewController") as?
                FavouritesRestaurantsViewController else { return }
        
        // Add icon for tabBar tab
        let icon = UITabBarItem(title: "Favourites Restaurants", image: UIImage(named: "FavoutritesMark"), selectedImage: UIImage(named: "FavoutritesMarkFill"))
        favouritesRestaurantsVC.tabBarItem = icon
        
        favouritesRestaurantsVM = FavouritesRestaurantsViewModel()
        favouritesRestaurantsVM?.actionDelegate = self
        restaurantInfoVM = RestaurantInfoViewModel()
        
        navigationController?.pushViewController(favouritesRestaurantsVC, animated: true)
    }
}

extension FavouritesRestaurantsCoordinator: FavRestaurantsCoordDelegateProtocol {
    func showRestaurantInfo() {
        
    }
}

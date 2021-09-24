//
//  FavouritesRestaurantsCoordinator.swift
//  restaurantsManager
//
//  Created by Moshkina on 03.06.2021.
//

import UIKit

class FavouritesRestaurantsCoordinator: Coordinator {

    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController?

    private var favouritesRestaurantsVM: FavouritesRestaurantsViewModel?
    private var restaurantInfoVM: RestaurantInfoViewModel?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start(networkService: RestaurantsNetworkService) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)

        guard let favouritesRestaurantsVC = storyboard
                .instantiateViewController(identifier: "FavouritesRestaurantsViewController") as?
                FavouritesRestaurantsViewController else { return }

        // Add icon for tabBar tab
        let icon = UITabBarItem(title: "Favourites Restaurants",
                                image: UIImage(named: "FavoutritesMark"),
                                selectedImage: UIImage(named: "FavoutritesMarkFill"))
        favouritesRestaurantsVC.tabBarItem = icon

        favouritesRestaurantsVM = FavouritesRestaurantsViewModel(networkService: networkService)
        favouritesRestaurantsVM?.actionDelegate = self
        
        favouritesRestaurantsVC.viewModel = favouritesRestaurantsVM
        
        navigationController?.pushViewController(favouritesRestaurantsVC, animated: true)
    }
}

extension FavouritesRestaurantsCoordinator: RestaurantCoordinatorDelegateProtocol {
    func showRestaurantInfo(restaurant: Restaurant) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let infoRestaurantVC = storyBoard
                .instantiateViewController(identifier: "RestaurantInfoViewController") as? RestaurantInfoViewController else { return }
            
        restaurantInfoVM = RestaurantInfoViewModel(restaurant: restaurant)
        restaurantInfoVM?.viewDelegate = infoRestaurantVC
            
        infoRestaurantVC.viewModel = restaurantInfoVM
            
        navigationController?.isNavigationBarHidden = false
        navigationController?.pushViewController(infoRestaurantVC, animated: true)
    }
}

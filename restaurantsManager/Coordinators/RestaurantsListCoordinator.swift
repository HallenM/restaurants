//
//  ListRestaurantsCoordinator.swift
//  restaurantsManager
//
//  Created by developer on 12.03.2021.
//

import UIKit

protocol RestaurantCoordinatorDelegateProtocol: class {
    func showRestaurantInfo(restaurant: Restaurant)
}

class RestaurantsListCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController?
    
    private var restaurantsListVM: RestaurantsListViewModel?
    private var restaurantInfoVM: RestaurantInfoViewModel?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start(networkService: RestaurantsNetworkService) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let restaurantsListVC = storyboard
                .instantiateViewController(identifier: "RestaurantsListViewController") as?
                RestaurantsListViewController else { return }
        
        // Add icon for tabBar tab
        let icon = UITabBarItem(title: "Restaurants List", image: UIImage(named: "List"), selectedImage: UIImage(named: "ListFill"))
        restaurantsListVC.tabBarItem = icon
        
        restaurantsListVM = RestaurantsListViewModel(networkService: networkService)
        restaurantsListVM?.actionDelegate = self
        
        restaurantsListVC.viewModel = restaurantsListVM
        
        navigationController?.pushViewController(restaurantsListVC, animated: true)
    }
}

extension RestaurantsListCoordinator: RestaurantCoordinatorDelegateProtocol {
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

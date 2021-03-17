//
//  ListRestaurantsCoordinator.swift
//  restaurantsManager
//
//  Created by developer on 12.03.2021.
//

import UIKit

protocol RestaurantsListCoordinatorDelegateProtocol: class {
    func showRestaurantInfo()
}

class RestaurantsListCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController?
    
    private var restaurantsListVM: RestaurantsListViewModel?
    private var restaurantInfoVM: RestaurantInfoViewModel?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let restaurantsListVC = storyboard
                .instantiateViewController(identifier: "RestaurantsListViewController") as?
                RestaurantsListViewController else { return }
        
        // Add icon for tabBar tab
        let icon = UITabBarItem(title: "Restaurants List", image: UIImage(named: "List"), selectedImage: UIImage(named: "ListFill"))
        restaurantsListVC.tabBarItem = icon
        
        restaurantsListVM = RestaurantsListViewModel()
        restaurantsListVM?.actionDelegate = self
        
        restaurantsListVC.viewModel = restaurantsListVM
        
        navigationController?.pushViewController(restaurantsListVC, animated: true)
    }
}

extension RestaurantsListCoordinator: RestaurantsListCoordinatorDelegateProtocol {
    func showRestaurantInfo() {
        
    }
}

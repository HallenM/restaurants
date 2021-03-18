//
//  MainCoordinator.swift
//  restaurantsManager
//
//  Created by developer on 12.03.2021.
//

import UIKit

protocol Coordinator: class {
    var childCoordinators: [Coordinator] {get set}
    var navigationController: UINavigationController? {get set}
    
    func start()
}

class MainCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController?
    
    var tabBarController: UITabBarController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        tabBarController = UITabBarController()
        
        // Create 3 coordinators, initialize their inner VCs and save in the stack
        // of appCoordinator
        var navigationC = UINavigationController()
        let restaurantsListCoordinator = RestaurantsListCoordinator(navigationController: navigationC)
        restaurantsListCoordinator.start()
        childCoordinators.append(restaurantsListCoordinator)
        
        navigationC = UINavigationController()
        let mapCoordinator = MapCoordinator(navigationController: navigationC)
        mapCoordinator.start()
        childCoordinators.append(mapCoordinator)
        
        navigationC = UINavigationController()
        let favouritesRestaurantsCoordinator = FavouritesRestaurantsCoordinator(navigationController: navigationC)
        favouritesRestaurantsCoordinator.start()
        childCoordinators.append(favouritesRestaurantsCoordinator)
        
        // Get 3 VC for add to the stack of TabBarController
        guard let firstVC = restaurantsListCoordinator.navigationController?
                .topViewController else { return }
        
        guard let secondVC = mapCoordinator.navigationController?
                .topViewController else { return }
    
        guard let thirdVC = favouritesRestaurantsCoordinator.navigationController?
                .topViewController else { return }
        
        tabBarController?.viewControllers = [firstVC, secondVC, thirdVC]
        
        guard let tabBarController = tabBarController else { return }        
        navigationController?.pushViewController(tabBarController, animated: false)
    }
}

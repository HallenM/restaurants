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
        
        restaurantsListVM = RestaurantsListViewModel()
        restaurantsListVM?.actionDelegate = self
        restaurantInfoVM = RestaurantInfoViewModel()
        
        navigationController?.pushViewController(restaurantsListVC, animated: true)
    }
}

extension RestaurantsListCoordinator: RestaurantsListCoordinatorDelegateProtocol {
    func showRestaurantInfo() {
        
    }
}

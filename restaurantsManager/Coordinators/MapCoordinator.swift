//
//  MapCoordinator.swift
//  restaurantsManager
//
//  Created by developer on 12.03.2021.
//

import UIKit

class MapCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController?
    
    private var mapVM: MapViewModel?
    private var restaurantInfoVM: RestaurantInfoViewModel?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let mapVC = storyboard
                .instantiateViewController(identifier: "MapViewController") as?
                MapViewController else { return }
        
        // Add icon for tabBar tab
        let icon = UITabBarItem(title: "Map", image: UIImage(named: "MapWithPin"), selectedImage: UIImage(named: "MapWithPinFill"))
        mapVC.tabBarItem = icon
        
        mapVM = MapViewModel()
        mapVM?.actionDelegate = self
        
        mapVC.viewModel = mapVM
        
        navigationController?.pushViewController(mapVC, animated: true)
    }
}

extension MapCoordinator: RestaurantCoordinatorDelegateProtocol {
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

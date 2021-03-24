//
//  ListRestaurantsCoordinator.swift
//  restaurantsManager
//
//  Created by developer on 12.03.2021.
//

import UIKit

protocol RestaurantsListCoordinatorDelegateProtocol: class {
    func showRestaurantInfo(restaurant: Restaurant)
    func showModalWindow(controller: UIViewController)
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
    func showRestaurantInfo(restaurant: Restaurant) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let infoRestaurantVC = storyBoard
                .instantiateViewController(identifier: "RestaurantInfoViewController") as? RestaurantInfoViewController else { return }
        
        restaurantInfoVM = RestaurantInfoViewModel(restaurant: restaurant)
        restaurantInfoVM?.actionDelegate = self
        
        infoRestaurantVC.viewModel = restaurantInfoVM
        
        navigationController?.isNavigationBarHidden = false
        navigationController?.pushViewController(infoRestaurantVC, animated: true)
    }
    
    func showModalWindow(controller: UIViewController) {
        /*let modalVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ModalViewController") as! ModalViewController
        let vc = navigationController?.topViewController
        vc.addChildViewController(modalVC)
        modalVC.view.frame = self.vc.frame
        vc.addSubview(modalVC.view)
                
        modalVC.didMove(toParentViewController: self)*/
    }
}

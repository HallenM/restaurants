//
//  ListRestaurantsCoordinator.swift
//  restaurantsManager
//
//  Created by developer on 12.03.2021.
//

import UIKit

class ListRestaurantsCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var viewController: UIViewController
    
    private var listRestaurantsVM: ListRestaurantsViewModel?
    private var restaurantInfoVM: RestaurantInfoViewModel?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func start() {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        //guard let
    }
}

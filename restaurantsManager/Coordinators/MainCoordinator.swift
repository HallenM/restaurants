//
//  MainCoordinator.swift
//  restaurantsManager
//
//  Created by developer on 12.03.2021.
//

import UIKit

protocol Coordinator: class {
    var childCoordinators: [Coordinator] {get set}
    var viewController: UIViewController {get set}
    
    func start()
}

class MainCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var viewController: UIViewController
    
    private var listRestaurantsVC: ListRestaurantsViewController?
    private var mapVC: MapViewController?
    private var favouriteRestaurantsVC: FavouritesRestaurantsViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func start() {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        //guard let 
    }
}

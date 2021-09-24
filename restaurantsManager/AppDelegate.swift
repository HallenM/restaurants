//
//  AppDelegate.swift
//  restaurantsManager
//
//  Created by developer on 11.03.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coordinator: MainCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Create a basic UIWindow
        window = UIWindow(frame: UIScreen.main.bounds)
                
        // Create the main controller to be used for app
        let viewController = UINavigationController()
        viewController.navigationBar.isHidden = true
        
        // Activate basic UIWindow
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
        
        // Send that into our coordinator so that it can display view controllers
        coordinator = MainCoordinator(navigationController: viewController)
        
        // Tell the coordinator to take over control
        let netvorkService = RestaurantsNetworkService()
        coordinator?.start(networkService: netvorkService)
        return true
    }
}

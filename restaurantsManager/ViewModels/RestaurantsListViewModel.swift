//
//  ListRestaurantsViewModel.swift
//  restaurantsManager
//
//  Created by developer on 12.03.2021.
//

import Foundation

protocol RestaurantsListViewDelegateProtocol: class {
    
}

class RestaurantsListViewModel {
    
    weak var viewDelegate: RestaurantsListViewDelegateProtocol?
    weak var actionDelegate: RestaurantsListCoordinatorDelegateProtocol?
}

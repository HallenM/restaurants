//
//  FavouritesRestaurantsViewModel.swift
//  restaurantsManager
//
//  Created by developer on 12.03.2021.
//

import Foundation

protocol FavouritesRestaurantsViewDelegateProtocol: class {
    
}

class FavouritesRestaurantsViewModel {
    
    weak var viewDelegate: FavouritesRestaurantsViewDelegateProtocol?
    weak var actionDelegate: FavRestaurantsCoordDelegateProtocol?
}

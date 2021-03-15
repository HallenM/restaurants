//
//  MapViewModel.swift
//  restaurantsManager
//
//  Created by developer on 12.03.2021.
//

import Foundation

protocol MapViewDelegateProtocol: class {
    
}

class MapViewModel {
    
    weak var viewDelegate: MapViewDelegateProtocol?
    weak var actionDelegate: MapCoordinatorDelegateProtocol?
    
}

//
//  Connectivity.swift
//  restaurantsManager
//
//  Created by developer on 02.04.2021.
//

import Alamofire

struct Connectivity {
    static let sharedInstance = NetworkReachabilityManager()!
    
    static var isConnectedToInternet:Bool {
        return self.sharedInstance.isReachable
    }
}

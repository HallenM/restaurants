//
//  RestaurantsNetworkService.swift
//  restaurantsManager
//
//  Created by developer on 12.03.2021.
//

import Alamofire

enum NetworkServiceError: Error {
    case noDataError(localizedError: String)
}

class RestaurantsNetworkService {
    
    func getRestaurantsList() {
        AF.request(
            "https://restaurants-f64d7.firebaseio.com/restaurants.json",
            method: .get)
            .validate()
            .responseJSON { responseJSON in
                switch responseJSON.result {
                case .success:
                    let str = responseJSON.result
                    print("Reeeeeesult:        \(str)")
                    //completion(.success(categoriesData.categories))
                case .failure(let error):
                    print("Fail_resp:  \(error)")
                    //completion(.failure(error))
                }
            }
    }
}

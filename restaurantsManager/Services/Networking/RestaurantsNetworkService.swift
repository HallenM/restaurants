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

class RestaurantsNetworkService: Equatable {
    
    private var restaurantList: [Restaurant] = []
    
    private var subscribers: [AnyClass] = []
    
    func getRestaurantsList(completion: @escaping(_ restaurants: Result<[Restaurant], Error>) -> Void) {
        AF.request(
            "https://restaurants-f64d7.firebaseio.com/restaurants.json",
            method: .get)
            .validate()
            .responseJSON { responseJSON in
                switch responseJSON.result {
                case .success:
                    
                    do {
                        guard let data = responseJSON.data else {
                            completion(.failure(NetworkServiceError.noDataError(localizedError: "No data from server")))
                            return
                        }
                        
                        let restaurantsData = try JSONDecoder().decode([Restaurant].self, from: data)
                        self.restaurantList = restaurantsData
                        
                        completion(.success(restaurantsData))
                        
                    } catch {
                        print("Error::   \(error)")
                        completion(.failure(error))
                    }
                case .failure(let error):
                    print("Fail_resp:  \(error)")
                    completion(.failure(error))
                }
            }
    }
    
    func subscribe(subscriber: AnyClass) {
        subscribers.append(subscriber)
    }
    
    func unsubscribe(subscriber: AnyClass) {
        for index in 0..<subscribers.count {
            if subscribers[index] === subscriber {
                subscribers.remove(at: index)
            }
        }
    }
    
    static func == (lhs: RestaurantsNetworkService, rhs: RestaurantsNetworkService) -> Bool {
        return true
    }
}

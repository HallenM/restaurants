//
//  ReviewNetworkService.swift
//  restaurantsManager
//
//  Created by developer on 12.03.2021.
//

import Alamofire

class ReviewNetworkService {
    
    // u{0022} - it's << " >>
    func getReviewsForRestaurant(restaurantId: String) {
        AF.request(
            "https://restaurants-f64d7.firebaseio.com/reviews.json?orderBy=\u{0022}restaurantIdu{0022}&equalTo=" + restaurantId,
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
    
    func addNewReview() {
        
    }
}

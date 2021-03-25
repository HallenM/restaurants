//
//  ReviewNetworkService.swift
//  restaurantsManager
//
//  Created by developer on 12.03.2021.
//

import Alamofire

class ReviewsNetworkService {
    
    func getReviewsForRestaurant(restaurantId: Int,
                                 completion: @escaping(_ reviews: Result<[Review], Error>) -> Void) {
        let link = "https://restaurants-f64d7.firebaseio.com/reviews.json"
        let parameters = ["orderBy": "\"restaurantId\"", "equalTo": String(restaurantId)]
        
        AF.request(
            link,
            method: .get,
            parameters: parameters)
            .validate()
            .responseJSON { responseJSON in
                switch responseJSON.result {
                case .success:
                    do {
                        guard let data = responseJSON.data else {
                            completion(.failure(NetworkServiceError.noDataError(localizedError: "No data from server")))
                            return
                        }
                        
                        let reviewsData = try JSONDecoder().decode([String: Review].self, from: data).values
                        
                        var reviews: [Review] = [Review]()
                        for review in reviewsData {
                            reviews.append(review)
                        }
                        
                        completion(.success(reviews))
                        
                    } catch {
                        print("Error::   \(error)")
                        completion(.failure(error))
                    }
                case .failure(let error):
                    print("Fail_response:  \(error)")
                    completion(.failure(error))
                }
            }
    }
    
    func addNewReview() {
        
    }
}

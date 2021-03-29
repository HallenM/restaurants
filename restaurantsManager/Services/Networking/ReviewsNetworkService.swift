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
        let parameters = [
            "orderBy": "\"restaurantId\"",
            "equalTo": String(restaurantId)
        ]
        
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
                        let decoder = JSONDecoder()
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss Z"
                        decoder.dateDecodingStrategy = .formatted(dateFormatter)
                        
                        let reviewsData = try decoder.decode([String: Review].self, from: data).values
                        
                        completion(.success(Array(reviewsData)))
                        
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
    
    func addNewReview(review: Review, completion: @escaping(_ response: Result<Bool, Error>) -> Void) {
        let link = "https://restaurants-f64d7.firebaseio.com/reviews.json"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'hh:mm:ss+07:00"
        let dateString = dateFormatter.string(from: review.date ?? Date())
        
        let parameters: [String: Any] = [
            "restaurantId": review.restaurantId,
            "author": review.author,
            "reviewText": review.reviewText,
            "date": dateString
        ]
        
        AF.request(
            link,
            method: .post,
            parameters: parameters,
            encoding: JSONEncoding.default)
            .validate()
            .responseJSON { responseJSON in
                switch responseJSON.result {
                case .success:
                    guard let statusCode = responseJSON.response?.statusCode else { return }
                    print("statusCode: ", statusCode)

                    if statusCode == 200 {
                        let value = responseJSON.result
                        print("KeyValue: ", value)
                        completion(.success(true))
                    } else {
                        print("Error, status code = \(statusCode)")
                        print("-----\(responseJSON.result)-----")
                        completion(.failure(NetworkServiceError.noDataError(
                                                localizedError: "Can`t get key of the new data. Response was end with statusCode: \(statusCode)")))
                    }
                case .failure(let error):
                    print("Fail_response:  \(error)")
                    completion(.failure(error))
                }
            }
    }
}

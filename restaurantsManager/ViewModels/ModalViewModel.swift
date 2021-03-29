//
//  ModalViewModel.swift
//  restaurantsManager
//
//  Created by developer on 26.03.2021.
//

import Foundation

class ModalViewModel {
    
    private var reviewAuthor: String? {
        didSet {
            haveFieldsData()
        }
    }
    
    private var reviewText: String? {
        didSet {
            haveFieldsData()
        }
    }
    
    private let restaurantId: Int
    
    weak var actionDelegate: NewReviewDelegateProtocol?
    
    weak var viewDelegate: ModalViewDelegateProtocol?
    
    private let networkService: ReviewsNetworkService = ReviewsNetworkService()
    
    init(restaurantId: Int) {
        self.restaurantId = restaurantId
    }
    
    func haveFieldsData() {
        if reviewAuthor?.count ?? 0 > 0 && reviewText?.count ?? 0 > 0 {
            viewDelegate?.buttonEnabled(isEnabled: true)
        } else {
            viewDelegate?.buttonEnabled(isEnabled: false)
        }
    }
    
    func getReviewAuthor() -> String {
        return reviewAuthor ?? ""
    }
    
    func setReviewAuthor(reviewAuthor: String) {
        self.reviewAuthor = reviewAuthor
    }
    
    func getReviewText() -> String {
        return reviewText ?? ""
    }
    
    func setReviewText(reviewText: String) {
        self.reviewText = reviewText
    }
    
    func getRestaurantId() -> Int {
        return restaurantId
    }
    
    func didTapButtonAdd() {
        
        let date = Date()
        
        let review = Review(restaurantId: restaurantId, author: reviewAuthor ?? "", reviewText: reviewText ?? "", date: date)
        
        self.viewDelegate?.buttonEnabled(isEnabled: false)
        networkService.addNewReview(review: review, completion: { (result) in
            switch result {
            case .success(let success):
                if success {
                    print("Review: \(review)")
                    self.actionDelegate?.addNewReview(review: review)
                    self.viewDelegate?.closeModalWindow()
                }
            case .failure(let error):
                print("ReviewsNetworkService Error; AddingReview Error: \(error)")
                self.viewDelegate?.errorAlert(title: "Error", message: "Review wasn`t added, please, try again.")
                self.viewDelegate?.buttonEnabled(isEnabled: true)
                
                return
            }
        })
    }
}

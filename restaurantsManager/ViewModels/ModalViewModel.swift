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
            print("reviewAuthor: \(reviewAuthor)")
            haveFieldsData()
        }
    }
    
    private var reviewText: String? {
        didSet {
            print("reviewText: \(reviewText)")
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
    
    func setReviewAuthor(authorReview: String) {
        self.reviewAuthor = authorReview
    }
    
    func getReviewText() -> String {
        return reviewText ?? ""
    }
    
    func setReviewText(textReview: String) {
        self.reviewText = textReview
    }
    
    func didTapButton() {
        
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy hh:mm:ss"
        let dateString = dateFormatter.string(from: date)
        
        let review = Review.init(restaurantId: restaurantId, author: reviewAuthor, reviewText: reviewText, date: dateString)
        
        // Add in database, if success -> addNewReview(review: review) else alert("something was wrong")
        print("Review: \(review)")
        actionDelegate?.addNewReview(review: review)
    }
}

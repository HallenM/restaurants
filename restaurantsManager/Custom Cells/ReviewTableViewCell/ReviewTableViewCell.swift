//
//  ReviewTableViewCell.swift
//  restaurantsManager
//
//  Created by developer on 24.03.2021.
//

import UIKit

class ReviewTableViewCell: UITableViewCell {

    @IBOutlet private weak var authorName: UILabel!
    @IBOutlet private weak var date: UILabel!
    @IBOutlet private weak var reviewText: UITextView!
    
    func customCell(cell: ReviewTableViewCell, review: Review) {
        
        cell.authorName.text = review.author
        cell.reviewText.text = review.reviewText
        
        if review.date != "" {
            guard let reviewDate = review.date else { return }
            let dateFormatter = DateFormatter()
            
            dateFormatter.dateFormat = "yyyy-MM-ddThh:mm:ss"
            let date = dateFormatter.date(from: reviewDate)
            
            dateFormatter.dateFormat = "dd-MM-yyyy hh:mm:ss"
            let dateString = dateFormatter.string(from: date ?? Date())
            
            cell.date.text = dateString
        } else {
            cell.date.text = review.date
        }
    }
}

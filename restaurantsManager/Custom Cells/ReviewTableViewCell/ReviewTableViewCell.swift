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
            var index = reviewDate.index(reviewDate.startIndex, offsetBy: 10)
            let date = reviewDate[..<index]
            let indexTime = reviewDate.index(index, offsetBy: 9)
            index = reviewDate.index(index, offsetBy: 1)
            let time = reviewDate[index..<indexTime]
            
            cell.date.text = "\(date);\(time)"
        } else {
            cell.date.text = review.date
        }
    }
}

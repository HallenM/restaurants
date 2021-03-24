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
    @IBOutlet private weak var reviewText: UITextField!
    
    func customCell(cell: ReviewTableViewCell, review: Review) {
        cell.authorName.text = review.author
        cell.date.text = review.date
        cell.reviewText.text = review.reviewText
    }
}

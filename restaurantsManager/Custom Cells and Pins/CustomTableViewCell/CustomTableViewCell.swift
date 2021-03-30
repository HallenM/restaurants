//
//  CustomTableViewCell.swift
//  restaurantsManager
//
//  Created by developer on 18.03.2021.
//

import UIKit
import Kingfisher

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var restaurantImage: UIImageView!
    @IBOutlet private weak var restaurantName: UILabel!
    @IBOutlet private weak var restaurantDescription: UILabel!
    
    func customCell(cell: CustomTableViewCell, imageURL: URL, name: String, description: String) {
        cell.restaurantImage.kf.setImage(with: imageURL)
        cell.restaurantName.text = name
        cell.restaurantDescription.text = description
    }
}

//
//  CustomCollectionViewCell.swift
//  restaurantsManager
//
//  Created by developer on 22.03.2021.
//

import UIKit
import Kingfisher

class CustomCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var imageView: UIImageView!

    func setupCell(imagePath: String) {
        let url = URL(string: imagePath)
        self.imageView.kf.setImage(with: url)
    }
    
    func setupEmptyCell() {
        self.imageView.backgroundColor = .green
    }

}

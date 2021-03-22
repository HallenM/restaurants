//
//  RestaurantInfoViewController.swift
//  restaurantsManager
//
//  Created by developer on 12.03.2021.
//

import UIKit
import Kingfisher

class RestaurantInfoViewController: UIViewController {
    
    @IBOutlet private weak var nameTextField: UILabel!
    @IBOutlet private weak var descriptionTextField: UITextView!
    @IBOutlet private weak var mainImage: UIImageView!
    @IBOutlet private weak var addressTextField: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    weak var viewModel: RestaurantInfoViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.text = viewModel?.getName()
        
        descriptionTextField.text = viewModel?.getDescription()
        
        let link = viewModel?.getMainImage()
        if link != "" {
            guard let link = link else { return }
            let url = URL(string: link)
            mainImage.kf.setImage(with: url)
        } else {
            mainImage.backgroundColor = .green
        }
        
        collectionView.register(UINib(nibName: "CustomCollectionViewCell", bundle: nil),
                                     forCellWithReuseIdentifier: "CustomCollectionViewCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let rating = viewModel?.getRating()
        
        let location = viewModel?.getLocation()
        
        let address = viewModel?.getAddress() ?? ""
        addressTextField.text = "\(addressTextField.text ?? "")  \(address)"
        
    }

}

extension RestaurantInfoViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.getImagesCount() ?? 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) ->
    UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCollectionViewCell", for: indexPath) as? CustomCollectionViewCell else { return CustomCollectionViewCell() }
        
        let links = viewModel?.getImages()
        
        if links?.count ?? 0 > 0 {
            cell.setupCell(imagePath: links?[indexPath.row] ?? "")
        } else {
            cell.setupEmptyCell()
        }
        
        return cell
    }
    
    
}

extension RestaurantInfoViewController: UICollectionViewDelegate {
    
}

//
//  RestaurantInfoViewController.swift
//  restaurantsManager
//
//  Created by developer on 12.03.2021.
//

import UIKit
import Kingfisher
import MapKit
import HCSStarRatingView

class RestaurantInfoViewController: UIViewController {
    
    @IBOutlet private weak var nameTextField: UILabel!
    @IBOutlet private weak var descriptionTextField: UITextView!
    @IBOutlet private weak var mainImage: UIImageView!
    @IBOutlet private weak var addressTextField: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var mapView: MKMapView!
    @IBOutlet private weak var buttonReview: UIView!
    @IBOutlet private weak var tableView: UITableView!
    
    weak var viewModel: RestaurantInfoViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set restaurant name
        nameTextField.text = viewModel?.getName()
        
        // Set restaurant description
        descriptionTextField.text = viewModel?.getDescription()
        
        // Set restaurant main image
        let link = viewModel?.getMainImage()
        if link != "" {
            guard let link = link else { return }
            let url = URL(string: link)
            mainImage.kf.setImage(with: url)
        } else {
            mainImage.backgroundColor = .green
        }
        
        // Set photo collection for restaurant
        collectionView.register(UINib(nibName: "CustomCollectionViewCell", bundle: nil),
                                     forCellWithReuseIdentifier: "CustomCollectionViewCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        
        // Set restaurant pin on the mapView
        let annotation = MKPointAnnotation()
        let location = viewModel?.getLocation()
        let cllCoordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(location?.lat ?? 0.0),
                                                   longitude: CLLocationDegrees(location?.lon ?? 0.0))
        annotation.coordinate = cllCoordinate
        mapView.addAnnotation(annotation)
        
        // Zooming map
        let region = MKCoordinateRegion(center: cllCoordinate, latitudinalMeters: cllCoordinate.latitude + 200,
                                        longitudinalMeters: cllCoordinate.longitude + 200)
        mapView.setRegion(region, animated: true)
        
        // Set restaurant address
        let address = viewModel?.getAddress() ?? ""
        addressTextField.text = "\(addressTextField.text ?? "")  \(address)"
        
        // Set restaurant rating
        let rating = viewModel?.getRating()
        
    }
    
    @IBAction func addNewReview(_ sender: Any) {
        print("Add new review")
    }
}

extension RestaurantInfoViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.getImagesCount() ?? 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) ->
    UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "CustomCollectionViewCell",
                for: indexPath) as? CustomCollectionViewCell else { return CustomCollectionViewCell() }
        
        let links = viewModel?.getImage(index: indexPath.row)
        if links != "" {
            cell.setupCell(imagePath: links ?? "")
        } else {
            cell.setupEmptyCell()
        }
        
        return cell
    }
    
}

extension RestaurantInfoViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 130, height: 130)
    }
}

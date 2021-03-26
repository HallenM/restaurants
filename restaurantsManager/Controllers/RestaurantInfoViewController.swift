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
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    @IBOutlet private weak var addressTextField: UILabel!
    @IBOutlet private weak var ratingView: HCSStarRatingView!
    @IBOutlet private weak var mapView: MKMapView!
    
    @IBOutlet private weak var buttonReview: UIView!
    @IBOutlet private weak var tableView: UITableView!
    
    weak var viewModel: RestaurantInfoViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setGeneralInfo()
        setGalleryInfo()
        setMapAndAddressInfo()
        setRatingInfo()
        setReviewsInfo()
        
        buttonReview.layer.cornerRadius = 5
    }
    
    func setGeneralInfo() {
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
    }
    
    func setGalleryInfo() {
        // Set photo collection for restaurant
        collectionView.register(UINib(nibName: "CustomCollectionViewCell", bundle: nil),
                                     forCellWithReuseIdentifier: "CustomCollectionViewCell")
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func setMapAndAddressInfo() {
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
    }
    
    func setRatingInfo() {
        // Set restaurant rating
        guard let rating = viewModel?.getRating() else { return }
        ratingView.tintColor = .systemYellow
        ratingView.allowsHalfStars = true
        ratingView.accurateHalfStars = true
        ratingView.maximumValue = 5
        ratingView.minimumValue = 0
        ratingView.value = CGFloat(rating / 2)
    }
    
    func setReviewsInfo() {
        // For list of reviews
        tableView.register(UINib(nibName: "ReviewTableViewCell", bundle: nil), forCellReuseIdentifier: "reviewCell")
        tableView.dataSource = self
        tableView.delegate = self
        
        // Add refreshControll (TableView has own refreshControl)
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.attributedTitle = NSAttributedString(string: "Updating...")
        tableView.refreshControl?.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
        
        // Send request for VM to initialize data for table
        viewModel?.initReviews(completion: {
                                DispatchQueue.main.async {
                                    self.tableView.reloadData()
                                }
        })
    }
    
    @IBAction func addNewReview(_ sender: Any) {
        // Open Modal Window
        viewModel?.didTapButton()
    }
    
    // Sender for refreshing data in table
    @objc func handleRefreshControl(sender: AnyObject) {
        viewModel?.getReviewsForTable(completion: {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.tableView.refreshControl?.endRefreshing()
            }
        })
    }
}

extension RestaurantInfoViewController: RestaurantInfoViewDelegateProtocol {
    func showModalWindow() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let modalVC = storyBoard
                .instantiateViewController(identifier: "ModalViewController") as? ModalViewController else { return }
        modalVC.modalPresentationStyle = .overFullScreen
        
        let id = viewModel?.getRestaurantID() ?? 0
        let modalVM = ModalViewModel(restaurantId: id)
        
        modalVM.actionDelegate = viewModel
        modalVM.viewDelegate = modalVC
        
        modalVC.viewModel = modalVM

        self.present(modalVC, animated: true)
    }
    
    func insertCell(index: Int) {
        let indexPath = IndexPath(row: index, section: 0)
        tableView.insertRows(at: [indexPath], with: .bottom)
    }
}

extension RestaurantInfoViewController: UITableViewDelegate {
    /*// Get the height to use for a row in a specified location.
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }*/
}

extension RestaurantInfoViewController: UITableViewDataSource {
    // Get number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.getRviewsCount() ?? 0
    }
    
    // Create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "reviewCell") as? ReviewTableViewCell else {
            return ReviewTableViewCell()
        }
        
        guard let review = viewModel?.getReview(index: indexPath.row) else { return ReviewTableViewCell() }
        
        cell.customCell(cell: cell, review: review)
                
        return cell
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

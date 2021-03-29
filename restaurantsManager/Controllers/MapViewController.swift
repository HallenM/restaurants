//
//  MapViewController.swift
//  restaurantsManager
//
//  Created by developer on 12.03.2021.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet private weak var mapView: MKMapView!
    
    weak var viewModel: MapViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Send request for VM to initialize data for table
        viewModel?.initData(completion: {
            self.setRestaurantsOnMap()
            })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
    }

    func setRestaurantsOnMap() {
        // Zooming map
        let centerCoordinate = CLLocationCoordinate2D(latitude: 54.9211081,
                                                   longitude: 82.9905861)
        
        let cllCoordinate = CLLocationCoordinate2D(latitude: 1554.9211081,
                                                   longitude: 1582.9905861)
        var region = MKCoordinateRegion(center: centerCoordinate, latitudinalMeters: cllCoordinate.latitude, longitudinalMeters: cllCoordinate.longitude)
        mapView.setRegion(region, animated: true)
        
        // Set restaurant pins on the mapView
        guard let len = viewModel?.getRestaurantsCount() else { return }
        for i in 0..<len {
            let annotation = MKPointAnnotation()
            let location = viewModel?.getRestaurantLocation(index: i)
            let cllCoordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(location?.lat ?? 0.0),
                                                       longitude: CLLocationDegrees(location?.lon ?? 0.0))
            annotation.coordinate = cllCoordinate
            mapView.addAnnotation(annotation)
        }
    }
}

//
//  MapViewController.swift
//  restaurantsManager
//
//  Created by developer on 12.03.2021.
//

import UIKit
import MapKit
import Kingfisher

class MapViewController: UIViewController {

    @IBOutlet private weak var mapView: MKMapView!
    
    weak var viewModel: MapViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Checking avaliable of network
        if Connectivity.isConnectedToInternet {
            // Send request for VM to initialize data for map
            viewModel?.initData(haveInternet: true, completion: {
                self.setRestaurantsOnMap()
                })
         } else {
            // Send request for VM to initialize data for map
            viewModel?.initData(haveInternet: false, completion: {
                self.setRestaurantsOnMap()
                })
        }
        
        self.mapView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
    }

    func setRestaurantsOnMap() {
        // Zooming map
        let centerCoordinate = CLLocationCoordinate2D(latitude: 54.9211081,
                                                   longitude: 82.9905861)
        
        let cllCoordinate = CLLocationCoordinate2D(latitude: 46000,
                                                   longitude: 15000)
        let region = MKCoordinateRegion(center: centerCoordinate,
                                        latitudinalMeters: cllCoordinate.latitude,
                                        longitudinalMeters: cllCoordinate.longitude)
        mapView.setRegion(region, animated: true)
        
        // Set restaurant pins on the mapView
        guard let len = viewModel?.getRestaurantsCount() else { return }
        for i in 0..<len {
            let annotation = MKPointAnnotation()
            let location = viewModel?.getRestaurantLocation(index: i)
            let cllCoordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(location?.lat ?? 0.0),
                                                       longitude: CLLocationDegrees(location?.lon ?? 0.0))
            annotation.coordinate = cllCoordinate
            annotation.title = viewModel?.getRestaurantName(index: i)
            annotation.subtitle = viewModel?.getRestaurantAddress(index: i)
            mapView.addAnnotation(annotation)
        }
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "customAnnotation")
        annotationView.image = UIImage(named: "Pin")
        annotationView.canShowCallout = true
        
        let calloutButton = UIButton(type: .detailDisclosure)
        annotationView.rightCalloutAccessoryView = calloutButton
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            viewModel?.tapInfoButton(name: (view.annotation?.title ?? "") ?? "")
        }
    }
}

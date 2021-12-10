//
//  ViewController.swift
//  Where
//
//  Created by ibrahim asiri on 18/04/1443 AH.
//

import UIKit
import MapKit
import CoreLocation

class MapVC: UIViewController, UISearchResultsUpdating {
    lazy var locationMng = CLLocationManager()

    lazy var mapView = MKMapView()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBrown
        locationMng.delegate = self
        locationMng.requestAlwaysAuthorization()
        locationMng.requestWhenInUseAuthorization()
        locationMng.startUpdatingLocation()
        
        view.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mapView.rightAnchor.constraint(equalTo: view.rightAnchor),
            mapView.leftAnchor.constraint(equalTo: view.leftAnchor)
        ])
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .save,
            target: self,
            action: #selector(saveTab))
    }
    
    @objc func saveTab() {
        present(PopVC(), animated: true, completion: nil)
    
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mapView.frame = CGRect(x: 0, y: view.safeAreaInsets.top,
                               width: view.frame.size.width,
                               height: view.frame.size.height)
    }

    func updateSearchResults(for searchController: UISearchController) {

    }
}

extension MapVC: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        
        Place.shared.userLat = location?.coordinate.latitude ?? 0
        Place.shared.userLong = location?.coordinate.longitude ?? 0
        
        let place = CLLocationCoordinate2D(latitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!)
        
        let region = MKCoordinateRegion(center: place, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        mapView.setRegion(region, animated: true)
        mapView.showsUserLocation = true
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}

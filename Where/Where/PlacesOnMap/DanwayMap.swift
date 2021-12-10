//
//  CangroMap.swift
//  Where
//
//  Created by ibrahim asiri on 23/04/1443 AH.
//

import UIKit
import MapKit

class DanwayMap: UIViewController {
    
    var lat: Double?
    var long: Double?
    lazy var returnBtn = UIButton()

    let mapV : MKMapView = {
        let map = MKMapView()
        map.overrideUserInterfaceStyle = .dark
        return map
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
             
        mapV.delegate = self
        
        let myLoc = MKPointAnnotation()
        myLoc.title = "Danway Bakery"
        myLoc.coordinate = CLLocationCoordinate2D(
            latitude: 18.24018982421746,
            longitude: 42.58194736137367)
        mapV.addAnnotation(myLoc)
        
        view.addSubview(mapV)
        mapV.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mapV.topAnchor.constraint(equalTo: view.topAnchor),
            mapV.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mapV.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapV.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        returnBtn.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(returnBtn)
        returnBtn.addTarget(self, action: #selector(returnTbd), for: .touchUpInside)
        returnBtn.setTitle("return", for: .normal)
        returnBtn.setTitleColor(.red, for: .normal)
        NSLayoutConstraint.activate([
            returnBtn.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            returnBtn.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20)
        
        ])
    }
    
    @objc func returnTbd() {
        dismiss(animated: true, completion: nil)
    }

}

extension DanwayMap: MKMapViewDelegate, CLLocationManagerDelegate {
    
}

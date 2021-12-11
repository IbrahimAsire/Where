
import UIKit
import MapKit

class PleacOnMap: UIViewController {
    
    var lat: Double?
    var long: Double?
    let returnBtn = UIButton()

    let mapV : MKMapView = {
        let map = MKMapView()
        return map
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
        setUpMap()
        let initLoc = CLLocation(latitude: 18.24018982421746, longitude: 42.58194736137367)
        setStartingLoc(location: initLoc, distance: 1000)
        addAnnotation()
        
        
    }
    
    func setUpMap() {
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
    
    // MARK:- To select an region on the map for the location ..
    func setStartingLoc(location: CLLocation, distance: CLLocationDistance) {
        
        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: distance, longitudinalMeters: distance)
        
        mapV.setRegion(region, animated: true)
        //determine the user's distance to move on the map
        mapV.setCameraBoundary(MKMapView.CameraBoundary(coordinateRegion: region), animated: true)
        //to zoom Limit Control(the maximum height)
        let zoomRange = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: 100000)
        mapV.setCameraZoomRange(zoomRange, animated: true)
    }
    
    // MARK:- To display a pin on the map
    func addAnnotation() {
        let pin = MKPointAnnotation()
        pin.coordinate = CLLocationCoordinate2D(latitude: 18.24018982421746, longitude: 42.58194736137367)
        pin.title = "Danway Bakery"
        pin.subtitle = "Cafe"
        mapV.addAnnotation(pin)
    }
}



import UIKit
import MapKit
import CoreLocation

class One: UIViewController, UISearchResultsUpdating {
    lazy var locationMng = CLLocationManager()

    lazy var mapView = MKMapView()
    
    var lat = 0.0
    var long = 0.0
   
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
        let vc = Two()
        
        vc.lat = lat
        vc.long = long
        present(vc, animated: true, completion: nil)
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

extension One: CLLocationManagerDelegate {
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations.last
        
        lat = location?.coordinate.latitude ?? 0
        long = location?.coordinate.longitude ?? 0
        
        let place = CLLocationCoordinate2D(latitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!)
        
        let region = MKCoordinateRegion(center: place, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        mapView.setRegion(region, animated: true)
        mapView.showsUserLocation = true
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}


import UIKit

class Two: UIViewController {
    
    var lat = 0.0
    var long = 0.0
    
    lazy var continar = UIView()
    lazy var nameTF = UITextField()
    lazy var descPlace = UITextView()
    lazy var saveBtn = UIButton()
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .systemGray
        view.alpha = 0.75
        setUpConst()
        print(lat)
        print(long)

    }
    
    func setUpConst() {
        view.addSubview(continar)
        continar.translatesAutoresizingMaskIntoConstraints = false
        continar.backgroundColor = .darkGray
        continar.alpha = 0.8
        continar.addSubview(nameTF)
        continar.addSubview(descPlace)
        continar.addSubview(saveBtn)
        NSLayoutConstraint.activate([
            continar.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            continar.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5),
            continar.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5),
            continar.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -450)
        ])
        
        view.addSubview(nameTF)
        nameTF.translatesAutoresizingMaskIntoConstraints = false
        nameTF.placeholder = "Name Of Place".Localizable()
        nameTF.backgroundColor = .secondarySystemBackground
        NSLayoutConstraint.activate([
            nameTF.topAnchor.constraint(equalTo: continar.topAnchor, constant: 50),
            nameTF.leftAnchor.constraint(equalTo: continar.leftAnchor, constant: 10),
            nameTF.rightAnchor.constraint(equalTo: continar.rightAnchor, constant: -10)
        ])
        
        view.addSubview(descPlace)
        descPlace.translatesAutoresizingMaskIntoConstraints = false
        descPlace.backgroundColor = .secondarySystemBackground
        NSLayoutConstraint.activate([
            descPlace.centerXAnchor.constraint(equalTo: continar.centerXAnchor),
            descPlace.topAnchor.constraint(equalTo: nameTF.bottomAnchor, constant: 10),
            descPlace.leftAnchor.constraint(equalTo: continar.leftAnchor, constant: 5),
            descPlace.rightAnchor.constraint(equalTo: continar.rightAnchor, constant: -5),
            descPlace.bottomAnchor.constraint(equalTo: continar.bottomAnchor, constant: -50)
        ])
        
        view.addSubview(saveBtn)
        saveBtn.translatesAutoresizingMaskIntoConstraints = false
        saveBtn.addTarget(self, action: #selector(saveTbd), for: .touchUpInside)
        saveBtn.backgroundColor = .systemBrown
        saveBtn.setTitle("Save".Localizable(), for: .normal)
        saveBtn.layer.cornerRadius = 5
        saveBtn.setTitleColor(.white, for: .normal)
        NSLayoutConstraint.activate([
            saveBtn.topAnchor.constraint(equalTo: descPlace.bottomAnchor, constant: 10),
            saveBtn.centerXAnchor.constraint(equalTo: continar.centerXAnchor),
            saveBtn.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    @objc func saveTbd() {
        print("saving")
                
        let newPlace = NewPlace(id: UUID().uuidString, namePlace: nameTF.text!, descPlace: descPlace.text, time: Date(), userLat: lat, userLong: long)
        
        NewPlacesService.shared.addPlace(place: newPlace)
        dismiss(animated: true, completion: nil)
        
//        let newLandMark = LandMark()
//        newLandMark.name = nameTF.text!
//        newLandMark.desc = descPlace.text
//        newLandMark.lat = Place.shared.userLat
//        newLandMark.long = Place.shared.userLong
//
//        try! realm.write {
//            realm.add(newLandMark)
//
//        }
    }
}


import UIKit
import CoreLocation
import MapKit

class Three: UIViewController , UITableViewDataSource, UITableViewDelegate {
        
    var newPlace: [NewPlace] = []

    let tableView = UITableView()

//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(true)
//
//        tableView.reloadData()
//
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NewPlacesService.shared.listenToPlaceInfo { newplaces in
            self.newPlace = newplaces
            self.tableView.reloadData()
        }
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CellThree.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = .systemBrown
        tableView.rowHeight = 80
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newPlace.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CellThree
        
        let data = newPlace[indexPath.row]
        
        cell.titlePlase.text = data.namePlace
        cell.descPlace.text = data.descPlace
        cell.timeLbl.text = "\(data.time)"

        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            
        if editingStyle == .delete {
            let landMark = newPlace[indexPath.row]
            
            NewPlacesService.shared.delete(place: landMark)
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let latitude:CLLocationDegrees = newPlace[indexPath.row].userLat
        let longitude:CLLocationDegrees = newPlace[indexPath.row].userLong

        let regionDistance:CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.openInMaps(launchOptions: options)
    }
}


import UIKit

class CellThree: UITableViewCell {
    let titlePlase = UILabel()
    let descPlace = UILabel()
    let timeLbl = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style , reuseIdentifier: reuseIdentifier )
        
        titlePlase.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(titlePlase)
        NSLayoutConstraint.activate([
            titlePlase.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titlePlase.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            titlePlase.widthAnchor.constraint(equalToConstant: 150)
            ])
        
        timeLbl.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(timeLbl)
        NSLayoutConstraint.activate([
            timeLbl.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            timeLbl.rightAnchor.constraint(equalTo: rightAnchor, constant: -10)
            ])

        descPlace.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(descPlace)
        descPlace.numberOfLines = 0
        NSLayoutConstraint.activate([
            descPlace.topAnchor.constraint(equalTo: titlePlase.bottomAnchor, constant: 10),
            descPlace.leftAnchor.constraint(equalTo: leftAnchor, constant: 10)
            ])
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}

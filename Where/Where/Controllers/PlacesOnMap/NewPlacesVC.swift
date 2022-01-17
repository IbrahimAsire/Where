
import UIKit
import CoreLocation
import MapKit
import FirebaseAuth
import Firebase

class NewPlacesVC: UIViewController , UITableViewDataSource, UITableViewDelegate {
    
    var db = Firestore.firestore()
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
        
        readPlases()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(NewPlaceCell.self, forCellReuseIdentifier: "cell")
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NewPlaceCell
        
        let data = newPlace[indexPath.row]
        
        cell.titlePlase.text = data.namePlace
        cell.descPlace.text = data.descPlace
//        cell.timeLbl.text = "\(data.time)"

        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            
        if editingStyle == .delete {
            let landMark = newPlace[indexPath.row]
            
            db.collection("newPlaces").document(landMark.id!).delete()
            self.tableView.reloadData()
        }
    }
    
    func readPlases(){
        let db = Firestore.firestore()
        let userID = Auth.auth().currentUser?.uid
        db.collection("newPlaces").addSnapshotListener { snapshot, error in
            if error == nil {
//                self.newPlace.removeAll()
                guard let data = snapshot?.documents else {return}
                for doc in data {
                    self.newPlace.append(NewPlace(id: doc.get("id") as? String, namePlace: doc.get("namePlace") as? String, descPlace: doc.get("descPlace") as? String, userLat: (doc.get("userLat") as? Double), userLong: (doc.get("userLong") as? Double)) )
                    print(doc.get("name"))
                }
                self.tableView.reloadData()
            }
        }
        
    }

      
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let latitude:CLLocationDegrees = newPlace[indexPath.row].userLat!
        let longitude:CLLocationDegrees = newPlace[indexPath.row].userLong!

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







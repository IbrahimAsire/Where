
import UIKit
import RealmSwift
import CoreLocation
import MapKit

class PlacesVC: UIViewController , UITableViewDataSource, UITableViewDelegate {
    
    let realm = try! Realm()

    let tabelView = UITableView()

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        tabelView.reloadData()
        
        print(Place.shared.landMarks)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let landMarks = realm.objects(LandMark.self)
        Place.shared.landMarks = landMarks
        
        tabelView.dataSource = self
        tabelView.delegate = self
        tabelView.register(Cell.self, forCellReuseIdentifier: "cell")
        tabelView.backgroundColor = .systemBrown
        tabelView.rowHeight = 80
        tabelView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tabelView)
        NSLayoutConstraint.activate([
            tabelView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tabelView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tabelView.topAnchor.constraint(equalTo: view.topAnchor),
            tabelView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Place.shared.landMarks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        as! Cell
        
        let data = Place.shared.landMarks[indexPath.row]
        
        cell.backgroundColor = .white
        cell.titlePlase.text = data.name
        cell.descPlace.text = data.desc
        cell.timeLbl.text = DateFormatter.localizedString(from: data.time, dateStyle: .short, timeStyle: .short)

        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            
        if editingStyle == .delete {
            let landMark = Place.shared.landMarks[indexPath.row]
                
            try! realm.write {
                realm.delete(landMark)
            }
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let latitude:CLLocationDegrees = Place.shared.landMarks[indexPath.row].lat
        let longitude:CLLocationDegrees = Place.shared.landMarks[indexPath.row].long

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

class Cell: UITableViewCell {
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


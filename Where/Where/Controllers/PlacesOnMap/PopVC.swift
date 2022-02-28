
import UIKit
import CoreLocation
import FirebaseAuth
import FirebaseFirestore

class PopVC: UIViewController {
    
    var lat = 0.0
    var long = 0.0
    
    let db = Firestore.firestore()
    
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
    
    private func setUpConst() {
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
        
        let userID = Auth.auth().currentUser?.uid
        let placeID = UUID().uuidString
        let newLoc = NewPlace(placeID: placeID, id: userID, namePlace: nameTF.text, descPlace: descPlace.text, time: Date(), userLat: lat, userLong: long)
        db.collection("newPlaces").document("\(String(describing: placeID))").setData(newLoc.getData())
        
        dismiss(animated: true, completion: nil)
        
    }
}


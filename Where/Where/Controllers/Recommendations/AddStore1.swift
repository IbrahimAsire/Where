
import UIKit
import Firebase

class AddStore1: UIViewController {
    
    let storeTF = UITextField()
    let pressBtn = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBrown
        setUpConst()
        
    }
    
    func setUpConst() {
        view.addSubview(storeTF)
        storeTF.translatesAutoresizingMaskIntoConstraints = false
        storeTF.placeholder = "store name".Localizable()
        storeTF.borderStyle = .roundedRect
        NSLayoutConstraint.activate([
            storeTF.topAnchor.constraint(equalTo: view.topAnchor, constant: 130),
            storeTF.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            storeTF.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30)
        ])
        
        view.addSubview(pressBtn)
        pressBtn.translatesAutoresizingMaskIntoConstraints = false
        pressBtn.setTitle("Save".Localizable(), for: .normal)
        pressBtn.setTitleColor(.systemBlue, for: .normal)
        pressBtn.addTarget(self, action: #selector(saveTpd), for: .touchUpInside)
        NSLayoutConstraint.activate([
            pressBtn.topAnchor.constraint(equalTo: storeTF.bottomAnchor, constant: 120),
            pressBtn.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30)
        ])
        
    }
    
    @objc func saveTpd() {
        let db = Firestore.firestore()
        let storeID = UUID().uuidString
        db.collection("recommendations").document(storeID).setData([
            "storeName": storeTF.text
        ])
    }
}


import UIKit
import Firebase

class RecommVC1: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var recomm = [Recomm]()
    let db = Firestore.firestore()
    let itemID = UUID().uuidString
        
    let tableView: UITableView = {
        $0.register(ReacommCell1.self, forCellReuseIdentifier: "SPCell")
        $0.rowHeight = 280
        return $0
    }(UITableView())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBrown
        tableView.dataSource = self
        tableView.delegate = self
        loadItems()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(Add))
        
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor)
            
        ])
        
    }
    
    @objc func Add() {
        let vc = AddItem1()
        vc.itemID = itemID
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return recomm.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SPCell", for: indexPath) as! ReacommCell1
        let info = recomm[indexPath.row]
        
        cell.itemNameLbl.text = info.recommTitle
        cell.storeNameLbl.text = info.storeName
                
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }
    
    
    func loadItems() {
        db.collection("recommendations").addSnapshotListener { snapshot, error in
            if error != nil {
                return
            }
            
            guard let items = snapshot?.documents else {return}
            
            for item in items {
                let data = item.data()
                guard
                    let iteamName = data["itemName"] as? String,
                    let storeName = data["storName"] as? String,
                    let storeID = data["itemID"] as? String,
                    let userID = data["userID"] as? String
                else {
                    continue
                }
                
                self.recomm.append(Recomm(userID: userID, recommID: storeID, recommTitle: iteamName, recommdetils: nil, recommImg: nil, storeName: storeName))
            }
            
        }
       
    }
    
}


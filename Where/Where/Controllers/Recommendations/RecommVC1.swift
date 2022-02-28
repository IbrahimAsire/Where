
import UIKit
import Firebase
import FirebaseStorage

class RecommVC1: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let imgItem: Recomm? = nil
    var recomm = [Recomm]()
    let db = Firestore.firestore()
    let itemID = UUID().uuidString
    let storage = Storage.storage()
    
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
        readImgFS()
        
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
        
        cell.itemNameLbl.text = info.recommdetils
        cell.storeNameLbl.text = info.storeName
        cell.itemImg = info.itemImg!
        
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
                    let itemID = data["itemID"] as? String,
                    let userID = data["userID"] as? String,
                    let itemImg = data["itemImageURL"]
                else {
                    continue
                }
                
                self.recomm.append(Recomm(userID: userID, recommID: itemID, recommdetils: iteamName, storeName: storeName, itemImg: itemImg as? UIImageView))
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
    }
    
    private func readImgFS(){
        db.collection("recommendations").addSnapshotListener { querySnapshot, error in
            if let e = error {
                print(e)
            } else {
                
                if let snapshotDocs = querySnapshot?.documents {
                    for doc in snapshotDocs {
                        let data = doc.data()
                        
                        let imageURL = data["itemImageURL"] as? String
                        
                        let httpsReference = self.storage.reference(forURL: imageURL!)
                        
                        httpsReference.getData(maxSize: 1 * 1024 * 1024) { data, error in
                            if let error = error {
                                print("ERROR GETTING DATA \(error.localizedDescription)")
                            } else {
                                DispatchQueue.main.async {
                                    self.imgItem?.itemImg!.image = UIImage(data: data!)
                                }
                            }
                        }
                        
                    }
                }
            }
        }
    }
}


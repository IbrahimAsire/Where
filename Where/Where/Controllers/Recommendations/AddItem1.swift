
import UIKit
import CoreData
import Firebase
import FirebaseStorage

class AddItem1: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    let db = Firestore.firestore()
    let storage = Storage.storage()
    
    var listStore = [Recomm]()
    var editOrDelete: Items?
    let userID = Auth.auth().currentUser?.uid
    var storeName = ""
    var storeID = ""
    
    let itemTF = UITextField()
    var imgItem = UIImageView()
    let pickerStore = UIPickerView()
    var imgPicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBrown
        imgPicker = UIImagePickerController()
        imgPicker.delegate = self
        
        let save =  UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTpd))
        let addStore = UIBarButtonItem(title: "Add Title".Localizable(), style: .done, target: self, action: #selector(addStore))
        let deleteItem = UIBarButtonItem(image: UIImage(systemName: "trash"), style: .plain, target: self, action: #selector(deleteTpd))
        
        navigationItem.rightBarButtonItems = [save, addStore, deleteItem]
        
        setUpConst()
        loadStores()
        if editOrDelete != nil {
            loadForEdit()
        }
        
    }
    
    func setUpConst() {
        
        view.addSubview(itemTF)
        itemTF.translatesAutoresizingMaskIntoConstraints = false
        itemTF.placeholder = "item name".Localizable()
        itemTF.borderStyle = .roundedRect
        NSLayoutConstraint.activate([
            itemTF.topAnchor.constraint(equalTo: view.topAnchor, constant: 160),
            itemTF.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            itemTF.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30)
        ])
        
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(selectImgTpd))
        imgItem.isUserInteractionEnabled = true
        imgItem.addGestureRecognizer(tapGR)
        view.addSubview(imgItem)
        imgItem.translatesAutoresizingMaskIntoConstraints = false
        imgItem.image = UIImage(named: "load")
        imgItem.contentMode = .scaleAspectFit
        NSLayoutConstraint.activate([
            imgItem.topAnchor.constraint(equalTo: itemTF.bottomAnchor, constant: 60),
            imgItem.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            imgItem.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            imgItem.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        view.addSubview(pickerStore)
        pickerStore.translatesAutoresizingMaskIntoConstraints = false
        pickerStore.dataSource = self
        pickerStore.delegate = self
        NSLayoutConstraint.activate([
            pickerStore.topAnchor.constraint(equalTo: imgItem.bottomAnchor, constant: 30),
            pickerStore.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
    }
    
    @objc func saveTpd() {
        db.collection("recommendations").document(storeID).setData([
            "itemName": itemTF,
            "storName": storeName,
        ], merge: true)
    }
    
    @objc func addStore() {
        navigationController?.pushViewController(AddStore1(), animated: true)
        
    }
    
    @objc func deleteTpd() {
        if userID == "xDAj9JkdzPUQyXPp9Jyxivazm9q2" {
            if editOrDelete != nil {
                context.delete(editOrDelete!)
                ad.saveContext()
                navigationController?.popViewController(animated: true)
                dismiss(animated: true)
            }
        }
    }
    
    func loadForEdit() {
        if let item = editOrDelete {
            itemTF.text = item.item_name
            imgItem.image = item.image as? UIImage
            
            if let store = item.toStore {
                var index = 0
                while index < listStore.count {
                    let row = listStore[index]
                    if row.storeName == store.name {
                        pickerStore.selectRow(index, inComponent: 0, animated: false)
                    }
                    index += 1
                }
            }
        }
        
    }
    
    // implment image picker
    @objc func selectImgTpd(_ sender: AnyObject){
        print("selected")
        present(imgPicker, animated: true, completion: nil)
        
    }
    
    func saveImgFS(url: String, userId: String) {
        db.document(userId).setData([
            "userImageURL": url,
        ], merge: true) { err in
            if let err = err {
                print("Error: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let userPickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {return}
        guard let d: Data = userPickedImage.jpegData(compressionQuality: 0.5) else { return }
//        guard let currentUser = Auth.auth().currentUser else {return}
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/png"
        
        let ref = storage.reference().child("UserProfileImages/\(userID).jpg")
        
        ref.putData(d, metadata: metadata) { (metadata, error) in
            if error == nil {
                ref.downloadURL(completion: { (url, error) in
                    self.saveImgFS(url: "\(url!)", userId: self.userID!)
                    
                })
            }else{
                print("error \(String(describing: error))")
            }
            
            self.imgPicker.dismiss(animated: true, completion: nil)
        }
        
    }
}

// MARK: - impleent for store pick
extension AddItem1: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func loadStores() {
        db.collection("recommendations").addSnapshotListener { [self] QuerySnapshot, error in
            if error != nil {
                return
            }
            guard let docs = QuerySnapshot?.documents else {return}
            
            for doc in docs {
                let data = doc.data()
                guard let storeName = data["storeName"] as? String
                        
                else {
                    continue
                }
                listStore.append(Recomm(userID: nil, recommID: nil, recommTitle: nil, recommdetils: nil, recommImg: nil, storeName: storeName))
            }
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return listStore.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let store = listStore[row]
        return store.storeName
    }
    
}

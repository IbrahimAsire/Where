
import UIKit
//import FirebaseFirestore
import FirebaseStorage
import Firebase
import FirebaseFirestore

class AddItem1: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    let db = Firestore.firestore()
    let storage = Storage.storage()
    
    var listStore = ["Book", "Cafe", "Test"]
    var editOrDelete: Items?
    let userID = Auth.auth().currentUser?.uid
    var storeName = "Book"
    var itemID = UUID().uuidString
    
    let itemTF = UITextField()
    var imgItem = UIImageView()
    let pickerStore = UIPickerView()
    var imgPicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBrown
//        imgPicker = UIImagePickerController()
//        imgPicker.delegate = self
        readImgFS()
        
        let save =  UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTpd))
        let deleteItem = UIBarButtonItem(image: UIImage(systemName: "trash"), style: .plain, target: self, action: #selector(deleteTpd))
        
        navigationItem.rightBarButtonItems = [save, deleteItem]
        
        setUpConst()
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
        
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(imageTpd))
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
        db.collection("recommendations").document(itemID).setData([
            "itemName": itemTF.text,
            "storName": storeName,
            "userID": userID,
            "itemID": itemID
        ], merge: true)
        
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

    // implment image picker
    @objc func selectImgTpd(_ sender: AnyObject){
        print("selected")
        present(imgPicker, animated: true, completion: nil)
        
    }
    
    func setupImgPicker() {
        imgPicker.delegate = self
        imgPicker.sourceType = .photoLibrary
        imgPicker.allowsEditing = true
        present(imgPicker, animated: true)
    }
    
    @objc func imageTpd() {
        setupImgPicker()
    }
    
    func saveImgFS(url: String, itemId: String) {
        db.collection("recommendations").document(itemId).setData([
            "itemImageURL": url,
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
        
        let ref = storage.reference().child("itemImg/\(itemID).jpg")
        
        ref.putData(d, metadata: metadata) { (metadata, error) in
            if error == nil {
                ref.downloadURL(completion: { (url, error) in
                    self.saveImgFS(url: "\(url!)", itemId: self.itemID)
                    
                })
            }else{
                print("error \(String(describing: error))")
            }
            
            picker.dismiss(animated: true, completion: nil)
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
                            
                            if let imageURL = data["itemImageURL"] as? String
                            {
                                let httpsReference = self.storage.reference(forURL: imageURL)
                                
                                httpsReference.getData(maxSize: 1 * 1024 * 1024) { data, error in
                                    if let error = error {
                                        print("ERROR GETTING DATA \(error.localizedDescription)")
                                    } else {
                                        DispatchQueue.main.async {
                                            self.imgItem.image = UIImage(data: data!)
                                        }
                                    }
                                }
                                
                            } else {
                                print("error converting data")
                                DispatchQueue.main.async {
                                    self.imgItem.image = UIImage(systemName: "person.fill.badge.plus")
                                }
                            }
                        }
                    }
                }
            }
    }
}

// MARK: - impleent for store pick
extension AddItem1: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return listStore.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let store = listStore[row]
        storeName = store
        return store
    }
    
}

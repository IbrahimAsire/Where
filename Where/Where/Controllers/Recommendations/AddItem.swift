
import UIKit
import CoreData
import Firebase

class AddItem: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var listStore = [StoreType]()
    var editOrDelete: Items?
    let user = Auth.auth().currentUser?.uid
    
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
        print("1")
        let newItem: Items!
        if editOrDelete == nil {
            newItem = Items(context: context)
        }else {
            newItem = editOrDelete
        }
        newItem.item_name = itemTF.text
        //        newItem.date_add = Date()
        newItem.image = imgItem.image
        newItem.toStore = listStore[pickerStore.selectedRow(inComponent: 0)]
        do {
            ad.saveContext()
            itemTF.text = ""
            print("saved")
        }
//        }catch let error {
//            print("Error: \(error)")
//        }
        
    }
    
    @objc func addStore() {
        navigationController?.pushViewController(AddStore(), animated: true)
        
    }
    
    @objc func deleteTpd() {
        if user == "xDAj9JkdzPUQyXPp9Jyxivazm9q2" {
            if editOrDelete != nil {
                context.delete(editOrDelete!)
                ad.saveContext()
                _ = navigationController?.popViewController(animated: true)
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
                    if row.name == store.name {
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
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imgItem.image = image
        }
        imgPicker.dismiss(animated: true, completion: nil)
    }
    
}

// MARK: - impleent for store pick
extension AddItem: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func loadStores() {
        let fecthReq: NSFetchRequest <StoreType> = StoreType.fetchRequest()
        do {
            listStore = try context.fetch(fecthReq)
        }catch {
            
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
        return store.name
    }
    
}

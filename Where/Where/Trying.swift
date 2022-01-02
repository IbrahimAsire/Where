//
//  Trying.swift
//  Where
//
//  Created by ibrahim asiri on 24/05/1443 AH.
//

import UIKit
import CoreData

class StorePhoto: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate {
     
    var controller = NSFetchedResultsController<Items>()
    
    let tableView: UITableView = {
        $0.register(SPCell.self, forCellReuseIdentifier: "SPCell")
        $0.rowHeight = 280
        return $0
    }(UITableView())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        
//        title = "List"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(Add))
        
        loadItems()
        
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
        navigationController?.pushViewController(AddItem(), animated: true)
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = controller.sections {
            let sectioInfo = sections[section]
            return sectioInfo.numberOfObjects
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SPCell", for: indexPath) as! SPCell
        
        configureCell(cell: cell, indexPath: indexPath as NSIndexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = AddItem()
        if let objc = controller.fetchedObjects {
            let item = objc[indexPath.row]
            vc.editOrDelete = item
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func configureCell(cell: SPCell, indexPath: NSIndexPath) {
        let singleItem = controller.object(at: indexPath as IndexPath)
        cell.setCell(item: singleItem)
    }
    
    func loadItems() {
        let fetchRequest: NSFetchRequest<Items> = Items.fetchRequest()
        let dateAddSort = NSSortDescriptor(key: "date_add", ascending: false)
        fetchRequest.sortDescriptors = [dateAddSort]
        controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        controller.delegate = self
        do {
            try controller.performFetch()
        }catch {
            print("Error")
        }
        
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.reloadData()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.reloadData()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        // data fetch
        switch(type) {
            
        case.insert:
            if let indexPath = indexPath {
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            break
        case.delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            break
        case.update:
            if let indexPath = indexPath {
                let cell = tableView.cellForRow(at: indexPath) as! SPCell
                configureCell(cell: cell, indexPath: indexPath as NSIndexPath)
            }
            break
        case.move:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            if let indexPath = indexPath {
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            break
        }
    }
    
}

class SPCell: UITableViewCell {
    
    var storeNameLbl = UILabel()
    var dateLbl = UILabel()
    var imgStore = UIImageView()
    var itemNameLbl = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(storeNameLbl)
        self.addSubview(dateLbl)
        self.addSubview(imgStore)
        self.addSubview(itemNameLbl)
        storeNameLbl.translatesAutoresizingMaskIntoConstraints = false
        storeNameLbl.text = "storeName"
        storeNameLbl.font = .boldSystemFont(ofSize: 18)
        dateLbl.translatesAutoresizingMaskIntoConstraints = false
        dateLbl.text = "Date"
        imgStore.translatesAutoresizingMaskIntoConstraints = false
        imgStore.image = UIImage(named: "cangro")
        itemNameLbl.translatesAutoresizingMaskIntoConstraints = false
        itemNameLbl.text = "itemName"
        
        NSLayoutConstraint.activate([
            storeNameLbl.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            storeNameLbl.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            dateLbl.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            dateLbl.leftAnchor.constraint(equalTo: storeNameLbl.rightAnchor, constant: 10),
            imgStore.topAnchor.constraint(equalTo: dateLbl.bottomAnchor, constant: 8),
            imgStore.centerXAnchor.constraint(equalTo: centerXAnchor),
            imgStore.heightAnchor.constraint(equalToConstant: 180),
            imgStore.widthAnchor.constraint(equalToConstant: 180),
            itemNameLbl.topAnchor.constraint(equalTo: imgStore.bottomAnchor, constant: 5),
            itemNameLbl.centerXAnchor.constraint(equalTo: centerXAnchor)
        
        ])
        
    }
    
    func setCell(item: Items) {
        storeNameLbl.text = item.item_name
        imgStore.image = item.image as? UIImage
        itemNameLbl.text = item.toStore?.name
        // convert date to String
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "MM/DD/yy h:mm a"
        dateLbl.text = dateFormat.string(from: item.date_add as! Date)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}


class AddItem: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var listStore = [StoreType]()
    var editOrDelete: Items?
    
    let itemTF = UITextField()
    var imgItem = UIImageView()
    let pressBtn = UIButton()
    let pickerStore = UIPickerView()
    var imgPicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        imgPicker = UIImagePickerController()
        imgPicker.delegate = self
        
        let save =  UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTpd))
        let addStore = UIBarButtonItem(title: "Add Store", style: .done, target: self, action: #selector(addStore))
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
        itemTF.placeholder = "item name"
        itemTF.borderStyle = .roundedRect
        NSLayoutConstraint.activate([
            itemTF.topAnchor.constraint(equalTo: view.topAnchor, constant: 127.5),
            itemTF.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            itemTF.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30)
        ])
        
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
        
        view.addSubview(pressBtn)
        pressBtn.translatesAutoresizingMaskIntoConstraints = false
        pressBtn.addTarget(self, action: #selector(selectImgTpd), for: .touchUpInside)
        NSLayoutConstraint.activate([
            pressBtn.topAnchor.constraint(equalTo: itemTF.bottomAnchor, constant: 60),
            pressBtn.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            pressBtn.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            pressBtn.heightAnchor.constraint(equalToConstant: 200)
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
        newItem.date_add = Date()
        newItem.image = imgItem.image
        newItem.toStore = listStore[pickerStore.selectedRow(inComponent: 0)]
        do {
            ad.saveContext()
            itemTF.text = ""
            print("saved")
        }catch {
            print("Error")
        }
        
    }
    
    @objc func addStore() {
        navigationController?.pushViewController(AddStore(), animated: true)
        
    }
    
    @objc func deleteTpd() {
        if editOrDelete != nil {
            context.delete(editOrDelete!)
            ad.saveContext()
            _ = navigationController?.popViewController(animated: true)
            dismiss(animated: true)
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
    @objc func selectImgTpd(){
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


class AddStore: UIViewController {
        
    let storeTF = UITextField()
    let pressBtn = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpConst()
        
    }
    
    func setUpConst() {
        view.addSubview(storeTF)
        storeTF.translatesAutoresizingMaskIntoConstraints = false
        storeTF.placeholder = "store name"
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
        let store = StoreType(context: context)
        store.name = storeTF.text
        do {
            ad.saveContext()
            storeTF.text = ""
            print("saved")
        }catch {
            print("cannot save")
        }
    }
}



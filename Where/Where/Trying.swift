//
//  Trying.swift
//  Where
//
//  Created by ibrahim asiri on 24/05/1443 AH.
//

import UIKit

class One: UIViewController, UITableViewDataSource, UITableViewDelegate {
        
    let tableView: UITableView = {
        $0.register(SPCell.self, forCellReuseIdentifier: "SPCell")
        $0.rowHeight = 280
        return $0
    }(UITableView())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView.dataSource = self
        
//        title = "List"
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
        navigationController?.pushViewController(AddTime(), animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SPCell", for: indexPath) as! SPCell
        
        cell.backgroundColor = .purple
        
        return cell
    }
    
}

class SPCell: UITableViewCell {
    
    lazy var storeNameLbl = UILabel()
    lazy var dateLbl = UILabel()
    lazy var imgStore = UIImageView()
    lazy var itemNameLbl = UILabel()
    
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
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}

import CoreData

class AddTime: UIViewController {
    
    let dataArr = ["1", "2", "3", "4", "5", "6"]
    var listStore = [StoreType]()
    
    let itemTF = UITextField()
    var imgItem = UIImageView()
    let pressBtn = UIButton()
    let pickerStore = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let save =  UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTpd))
        
        let addStore = UIBarButtonItem(title: "Add Store", style: .done, target: self, action: #selector(addStore))
        
        navigationItem.rightBarButtonItems = [save, addStore]
        
        
        setUpConst()
        loadStores()
        
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
        
    }
    
    @objc func addStore() {
        navigationController?.pushViewController(AddStore(), animated: true)
        
    }
    
    @objc func selectImgTpd(){
        print("selected")
        
    }
    
}

// MARK: - impleent for store pick
extension AddTime: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func loadStores() {
        let fecthReq: NSFetchRequest < StoreType > = StoreType.fetchRequest()
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



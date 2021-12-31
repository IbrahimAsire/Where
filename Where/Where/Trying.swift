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

class AddTime: UIViewController {
    
    let dataArr = ["1", "2", "3", "4", "5", "6"]
    
    let itemTF = UITextField()
    var imgItem = UIImageView()
    let pressBtn = UIButton()
    let picker = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let save =  UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTpd))
        
        let addStore = UIBarButtonItem(title: "Add Store", style: .done, target: self, action: #selector(addStore))
        
        navigationItem.rightBarButtonItems = [save, addStore]
        
        
        setUpConst()
        
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
        NSLayoutConstraint.activate([
            imgItem.topAnchor.constraint(equalTo: itemTF.bottomAnchor, constant: 60),
            imgItem.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            imgItem.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            imgItem.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        view.addSubview(pressBtn)
        pressBtn.translatesAutoresizingMaskIntoConstraints = false
        pressBtn.backgroundColor = .purple
        NSLayoutConstraint.activate([
            pressBtn.topAnchor.constraint(equalTo: itemTF.bottomAnchor, constant: 60),
            pressBtn.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            pressBtn.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            pressBtn.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        view.addSubview(picker)
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.dataSource = self
        picker.delegate = self
        NSLayoutConstraint.activate([
            picker.topAnchor.constraint(equalTo: imgItem.bottomAnchor, constant: 30),
            picker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
    }
    
    @objc func saveTpd() {
        print("1")
        
    }
    
    @objc func addStore() {
        navigationController?.pushViewController(AddStore(), animated: true)
        
    }
    
}

extension AddTime: UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataArr.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
       let row = dataArr[row]
       return row
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
        NSLayoutConstraint.activate([
            pressBtn.topAnchor.constraint(equalTo: storeTF.bottomAnchor, constant: 120),
            pressBtn.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30)
        ])
        
    }
}

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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTpd))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Add Store", style: .done, target: self, action: #selector(addStore))
    }
    
    @objc func saveTpd() {
        
    }
    
    @objc func addStore() {
        
    }
    
}

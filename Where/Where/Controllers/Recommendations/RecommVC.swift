
import UIKit
import CoreData

class RecommVC: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate {
     
    var controller = NSFetchedResultsController<Items>()
    
    let tableView: UITableView = {
        $0.register(ReacommCell.self, forCellReuseIdentifier: "SPCell")
        $0.rowHeight = 280
        return $0
    }(UITableView())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBrown
        tableView.dataSource = self
        tableView.delegate = self
        
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "SPCell", for: indexPath) as! ReacommCell
        
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
    
    func configureCell(cell: ReacommCell, indexPath: NSIndexPath) {
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
                let cell = tableView.cellForRow(at: indexPath) as! ReacommCell
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


import UIKit

class PSCell: UITableViewCell {
    
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

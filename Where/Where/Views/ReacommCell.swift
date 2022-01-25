
import UIKit

class ReacommCell: UITableViewCell {
    
    var itemNameLbl = UILabel()
    var dateLbl = UILabel()
    var imgStore = UIImageView()
    var storeNameLbl = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(itemNameLbl)
//        self.addSubview(dateLbl)
        self.addSubview(imgStore)
        self.addSubview(storeNameLbl)
        itemNameLbl.translatesAutoresizingMaskIntoConstraints = false
        itemNameLbl.font = .boldSystemFont(ofSize: 18)
        itemNameLbl.numberOfLines = 0
//        dateLbl.translatesAutoresizingMaskIntoConstraints = false
//        dateLbl.text = "Date"
        imgStore.translatesAutoresizingMaskIntoConstraints = false
        imgStore.image = UIImage(named: "cangro")
        storeNameLbl.translatesAutoresizingMaskIntoConstraints = false
        storeNameLbl.font = .boldSystemFont(ofSize: 18)
        
        NSLayoutConstraint.activate([
            itemNameLbl.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            itemNameLbl.centerXAnchor.constraint(equalTo: centerXAnchor),
//            dateLbl.topAnchor.constraint(equalTo: topAnchor, constant: 10),
//            dateLbl.leftAnchor.constraint(equalTo: itemNameLbl.rightAnchor, constant: 10),
            imgStore.topAnchor.constraint(equalTo: itemNameLbl.bottomAnchor, constant: 8),
            imgStore.centerXAnchor.constraint(equalTo: centerXAnchor),
            imgStore.heightAnchor.constraint(equalToConstant: 180),
            imgStore.widthAnchor.constraint(equalToConstant: 180),
            storeNameLbl.topAnchor.constraint(equalTo: imgStore.bottomAnchor, constant: 12),
            storeNameLbl.centerXAnchor.constraint(equalTo: centerXAnchor)
        
        ])
        
    }
    
    func setCell(item: Items) {
        itemNameLbl.text = item.item_name
        imgStore.image = item.image as? UIImage
        storeNameLbl.text = item.toStore?.name
        // convert date to String
//        let dateFormat = DateFormatter()
//        dateFormat.dateFormat = "MM/DD/yy h:mm a"
//        dateLbl.text = dateFormat.string(from: item.date_add!)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}

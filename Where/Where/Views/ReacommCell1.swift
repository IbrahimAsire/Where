
import UIKit

class ReacommCell1: UITableViewCell {
    
    var itemNameLbl = UILabel()
    var dateLbl = UILabel()
    var itemImg = UIImageView()
    var storeNameLbl = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(itemNameLbl)
        //        self.addSubview(dateLbl)
        self.addSubview(itemImg)
        self.addSubview(storeNameLbl)
        itemNameLbl.translatesAutoresizingMaskIntoConstraints = false
        itemNameLbl.font = .boldSystemFont(ofSize: 18)
        itemNameLbl.numberOfLines = 0
        //        dateLbl.translatesAutoresizingMaskIntoConstraints = false
        //        dateLbl.text = "Date"
        itemImg.translatesAutoresizingMaskIntoConstraints = false
        itemImg.image = UIImage(named: "cangro")
        storeNameLbl.translatesAutoresizingMaskIntoConstraints = false
        storeNameLbl.font = .boldSystemFont(ofSize: 18)
        
        NSLayoutConstraint.activate([
            itemNameLbl.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            itemNameLbl.centerXAnchor.constraint(equalTo: centerXAnchor),
            //            dateLbl.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            //            dateLbl.leftAnchor.constraint(equalTo: itemNameLbl.rightAnchor, constant: 10),
            itemImg.topAnchor.constraint(equalTo: itemNameLbl.bottomAnchor, constant: 8),
            itemImg.centerXAnchor.constraint(equalTo: centerXAnchor),
            itemImg.heightAnchor.constraint(equalToConstant: 180),
            itemImg.widthAnchor.constraint(equalToConstant: 180),
            storeNameLbl.topAnchor.constraint(equalTo: itemImg.bottomAnchor, constant: 12),
            storeNameLbl.centerXAnchor.constraint(equalTo: centerXAnchor)
            
        ])
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}

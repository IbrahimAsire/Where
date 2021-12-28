
import UIKit

class PlacesCell: UITableViewCell {
    let titlePlase = UILabel()
    let descPlace = UILabel()
    let timeLbl = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style , reuseIdentifier: reuseIdentifier )
        
        titlePlase.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(titlePlase)
        NSLayoutConstraint.activate([
            titlePlase.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titlePlase.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            titlePlase.widthAnchor.constraint(equalToConstant: 150)
            ])
        
        timeLbl.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(timeLbl)
        NSLayoutConstraint.activate([
            timeLbl.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            timeLbl.rightAnchor.constraint(equalTo: rightAnchor, constant: -10)
            ])

        descPlace.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(descPlace)
        descPlace.numberOfLines = 0
        NSLayoutConstraint.activate([
            descPlace.topAnchor.constraint(equalTo: titlePlase.bottomAnchor, constant: 10),
            descPlace.leftAnchor.constraint(equalTo: leftAnchor, constant: 10)
            ])
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}

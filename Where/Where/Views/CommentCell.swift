
import UIKit

class CommentCell: UITableViewCell {
    let titlePlase = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style , reuseIdentifier: reuseIdentifier )
        
        titlePlase.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(titlePlase)
        NSLayoutConstraint.activate([
            titlePlase.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titlePlase.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            titlePlase.widthAnchor.constraint(equalTo: widthAnchor)
            ])
        
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}

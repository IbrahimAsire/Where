
import UIKit

class CafesCell: UICollectionViewCell{
    
    let imgCafe = UIImageView()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        self.backgroundColor = .darkGray
        self.contentView.layer.cornerRadius = 20.0
        self.contentView.layer.borderWidth = 2.0
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        self.contentView.layer.masksToBounds = true
        self.contentView.backgroundColor = .white
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 5.0)
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 2.0
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 2
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
        
        imgCafe.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(imgCafe)
        NSLayoutConstraint.activate([
            imgCafe.rightAnchor.constraint(equalTo: rightAnchor ),
            imgCafe.leftAnchor.constraint(equalTo: leftAnchor),
            imgCafe.topAnchor.constraint(equalTo: topAnchor),
            imgCafe.heightAnchor.constraint(equalToConstant: 400),
        ])
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

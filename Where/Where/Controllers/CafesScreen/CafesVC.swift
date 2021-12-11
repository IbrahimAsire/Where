

import UIKit

class CafesVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let nameCafesLbl = UILabel()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBrown
        nameCafesLbl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameCafesLbl)
        nameCafesLbl.text = "Cafes"
        nameCafesLbl.textColor = .systemBackground
        nameCafesLbl.font = .boldSystemFont(ofSize: 40)
        NSLayoutConstraint.activate([
           nameCafesLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
           nameCafesLbl.topAnchor.constraint(equalTo: view.topAnchor, constant: 60)
        ])

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.alwaysBounceVertical = true
        collectionView.register(CafesCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.backgroundColor = .darkText

        NSLayoutConstraint.activate([
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor , constant: 16),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor , constant: -16),
            collectionView.topAnchor.constraint(equalTo: nameCafesLbl.bottomAnchor, constant: 10),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16)
        ])
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return detlCafe.count
   }

   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CafesCell
       let data = detlCafe[indexPath.row]

       cell.imgCafe.image = UIImage(named: data.showImg)
       cell.imgCafe.clipsToBounds = true
//       cell.nameCafe.text = data.title
       return cell
   }

   func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       let data = detlCafe[indexPath.row]

       let nextVC = ShowCafe()
       let camfOnMap = PleacOnMap()
       
       nextVC.cafeImg1.image = UIImage(named: data.img1)
       nextVC.cafeImg2.image = UIImage(named: data.img2)
       nextVC.nameCafe.text = data.nameCafe
       nextVC.detlCafe.text = data.descCafe
       
       self.present(nextVC, animated: true, completion: nil)
   }

   func collectionView(_ collectionView: UICollectionView,
                           layout collectionViewLayout: UICollectionViewLayout,
                           sizeForItemAt indexPath: IndexPath) -> CGSize {
           return CGSize(width: 350, height: 400)
       }

   func collectionView(_ collectionView: UICollectionView,
                       layout collectionViewLayout: UICollectionViewLayout,
                       insetForSectionAt section: Int) -> UIEdgeInsets {
       return UIEdgeInsets(top: 1, left: 0, bottom: 1, right: 0)
   }

   func collectionView(_ collectionView: UICollectionView,
                       layout collectionViewLayout: UICollectionViewLayout,
                       minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
       return 2
   }


}

   

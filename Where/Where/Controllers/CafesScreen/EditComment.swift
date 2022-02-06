

import UIKit
import Firebase

class EditComment: UIViewController {
    
    let db = Firestore.firestore()
    let userID = Auth.auth().currentUser!.uid
    
    let commentTV = UITextView()
    var nameCafe = ""
    let addBtn = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        view.alpha = 0.95
        
        commentTV.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(commentTV)
        addBtn.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addBtn)
        addBtn.setTitle("Save".Localizable(), for: .normal)
        addBtn.setTitleColor(.black, for: .normal)
        addBtn.backgroundColor = .white
        addBtn.layer.cornerRadius = 15
        addBtn.addTarget(self, action: #selector(editBtnTpd), for: .touchUpInside)
        NSLayoutConstraint.activate([
            commentTV.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            commentTV.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            commentTV.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            commentTV.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            addBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addBtn.topAnchor.constraint(equalTo: commentTV.bottomAnchor, constant: 12),
            addBtn.widthAnchor.constraint(equalToConstant: 120)
            
        ])
    }
    
    @objc func editBtnTpd() {
        db.collection("newComments").whereField("id", isEqualTo: userID).addSnapshotListener { snapshot, error in
            if error == nil {
                self.db.collection("newComments").whereField("nameCafe", isEqualTo: self.nameCafe).addSnapshotListener { snapshot, error in
                    if error == nil {
                        
                        self.dismiss(animated: true, completion: nil)
                        
                    }
                }
                
            }
            
        }
    }
}


import UIKit
import Firebase

class EditComment: UIViewController {
    
    let db = Firestore.firestore()
    
    var commentID = ""
    var nameCafe = ""
    
    let commentTV = UITextView()
    let addBtn = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        print(commentID)
        
        commentTV.translatesAutoresizingMaskIntoConstraints = false
        addBtn.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addBtn)
        view.addSubview(commentTV)
        commentTV.backgroundColor = .systemGray6
        addBtn.setTitle("Save", for: .normal)
        addBtn.setTitleColor(.black, for: .normal)
        addBtn.layer.cornerRadius = 5
        //        addBtn.backgroundColor = .white
        addBtn.addTarget(self, action: #selector(addBtnTpd), for: .touchUpInside)
        NSLayoutConstraint.activate([
            commentTV.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            commentTV.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            commentTV.widthAnchor.constraint(equalTo: view.widthAnchor),
            commentTV.heightAnchor.constraint(equalToConstant: 500),
            addBtn.topAnchor.constraint(equalTo: commentTV.bottomAnchor, constant: 12),
            addBtn.widthAnchor.constraint(equalToConstant: 120),
            addBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc func addBtnTpd(){
        if commentTV.text.isEmpty {
            let alertMsg = UIAlertController(title: "Must write", message: "Please type your comment", preferredStyle: .alert)
            alertMsg.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(alertMsg, animated: true)
            return
            
        } else {
            
            let userID = Auth.auth().currentUser!.uid
            let newComment = NewComment(id: userID, content: commentTV.text, nameCafe: nameCafe, commentID: commentID)
            self.db.collection("newComments")
                .document("\(String(describing: commentID))")
                .setData(newComment.getData(), merge: true)
            
            dismiss(animated: true, completion: nil)
            
        }
        
    }
    
}



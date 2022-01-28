
import UIKit
import Firebase

class AddComment: UIViewController, UITextViewDelegate {
    
    let db = Firestore.firestore()
    
    let commentTF = UITextView()
    let addButton = UIButton()
    var nameCafe = ""
    
    //    var comment: CommentCafe?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(nameCafe)
        
        view.backgroundColor = .lightGray
        title = "Comment".Localizable()
        
        setupNameNoteTF()
        setupAddNoteBtn()
        //        commentTF.text = comment?.comment
        
    }
    
    func setupNameNoteTF() {
        commentTF.backgroundColor = .systemGray6
        commentTF.layer.cornerRadius = 5
        commentTF.clipsToBounds = true
        commentTF.textAlignment = .left
        commentTF.autocorrectionType = .no
        commentTF.autocapitalizationType = .words
        commentTF.tintColor = .black
        commentTF.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(commentTF)
        commentTF.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        commentTF.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        commentTF.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        commentTF.heightAnchor.constraint(equalToConstant: 600).isActive = true
    }
    
    func setupAddNoteBtn() {
        
        addButton.layer.cornerRadius = 20
        addButton.layer.borderColor = UIColor.black.cgColor
        addButton.layer.borderWidth = 0.55
        addButton.backgroundColor = .white
        addButton.setTitle("Save".Localizable(), for: .normal)
        addButton.setTitleColor(.black, for: .normal)
        addButton.addTarget(self, action: #selector(addBtnTapped), for: .touchUpInside)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addButton)
        addButton.topAnchor.constraint(equalTo: commentTF.bottomAnchor, constant: 20).isActive = true
        addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        addButton.widthAnchor.constraint(equalToConstant: 300).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
    }
    
    @objc func addBtnTapped() {
        
        if commentTF.text.isEmpty {
            let alertMsg = UIAlertController(title: "Must write", message: "Please type your comment", preferredStyle: .alert)
            alertMsg.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(alertMsg, animated: true)
            return
            
        } else {
            
            let userID = Auth.auth().currentUser!.uid
            let commentID = UUID().uuidString
            let newComment = NewComment(id: userID, content: commentTF.text, nameCafe: nameCafe, commentID: commentID)
            self.db.collection("newComments").document("\(String(describing: commentID))").setData(newComment.getData())
            
            dismiss(animated: true, completion: nil)
            
        }
        
    }
    
}


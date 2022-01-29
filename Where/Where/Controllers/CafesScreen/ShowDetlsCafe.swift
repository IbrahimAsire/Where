
import UIKit
import MessageUI
import SafariServices
import Cosmos
import TinyConstraints
import Firebase
import CloudKit

class ShowDetlsCafe: UIViewController, MFMailComposeViewControllerDelegate, UINavigationControllerDelegate {
    
    let db = Firestore.firestore()
    let myID = Auth.auth().currentUser!.uid
    
    var lat = 0.0
    var long = 0.0
    var titleCafe = ""
    
    var comments: [NewComment] = []
    
    let cellId = "CommentCell"
    
    var cafeImg1 = UIImageView()
    var cafeImg2 = UIImageView()
    var nameCafe = UILabel()
    var detlCafe = UILabel()
    var mapBtn = UIButton()
    var addComment = UIButton()
    lazy var tableView = UITableView()
    var returnBtn = UIButton()
    var contactBtn = UIButton()
    
    lazy var cosmosView: CosmosView = {
        $0.settings.filledImage = UIImage(named: "starF")?.withRenderingMode(.alwaysOriginal)
        $0.settings.emptyImage = UIImage(named: "starE")?.withRenderingMode(.alwaysOriginal)
        $0.settings.starSize = 17
        $0.settings.starMargin = 2
        $0.settings.fillMode = .precise
        
        $0.text = "Rate"
        $0.settings.textColor = .systemBlue
        $0.settings.textMargin = 8
        return $0
    }(CosmosView())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        readComments()
        
        title = "Cafes".Localizable()
        view.backgroundColor = .white
        setUpConstraint()
        
    }
    
    func readComments(){
        db.collection("newComments").whereField("nameCafes", isEqualTo: titleCafe)
            .addSnapshotListener { snapshot, error in
                if error == nil {
                    //                self.newPlace.removeAll()
                    guard let data = snapshot?.documents else {return}
                    for doc in data {
                        self.comments.append(NewComment(id: doc.get("id") as? String, content: doc.get("comments") as? String, nameCafe: doc.get("nameCafes") as? String, commentID: doc.get("commentID") as? String))
                    }
                    self.tableView.reloadData()
                }
            }
        
    }
    
    func setUpConstraint() {
        
        view.addSubview(cafeImg1)
        cafeImg1.translatesAutoresizingMaskIntoConstraints = false
        cafeImg1.layer.masksToBounds = true
        cafeImg1.layer.cornerRadius = 5
        NSLayoutConstraint.activate([
            cafeImg1.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            cafeImg1.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5),
            cafeImg1.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -200),
            cafeImg1.heightAnchor.constraint(equalToConstant: 350),
            cafeImg2.widthAnchor.constraint(equalToConstant: 195)
        ])
        
        view.addSubview(cafeImg2)
        cafeImg2.translatesAutoresizingMaskIntoConstraints = false
        cafeImg2.layer.masksToBounds = true
        cafeImg2.layer.cornerRadius = 5
        NSLayoutConstraint.activate([
            cafeImg2.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5),
            cafeImg2.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            cafeImg2.heightAnchor.constraint(equalToConstant: 350),
            cafeImg2.widthAnchor.constraint(equalToConstant: 195)
        ])
        
        view.addSubview(nameCafe)
        nameCafe.translatesAutoresizingMaskIntoConstraints = false
        nameCafe.font = .boldSystemFont(ofSize: 20)
        NSLayoutConstraint.activate([
            nameCafe.topAnchor.constraint(equalTo: cafeImg1.bottomAnchor, constant: 5),
            nameCafe.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5)
        ])
        
        view.addSubview(detlCafe)
        detlCafe.translatesAutoresizingMaskIntoConstraints = false
        detlCafe.textColor = .gray
        detlCafe.font = .boldSystemFont(ofSize: 15)
        detlCafe.numberOfLines = 0
        NSLayoutConstraint.activate([
            detlCafe.topAnchor.constraint(equalTo: nameCafe.bottomAnchor, constant: 8),
            detlCafe.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5),
            detlCafe.widthAnchor.constraint(equalToConstant: 250)
        ])
        
        view.addSubview(mapBtn)
        mapBtn.translatesAutoresizingMaskIntoConstraints = false
        mapBtn.setBackgroundImage(UIImage(systemName: "mappin.and.ellipse"), for: .normal)
        mapBtn.tintColor = .lightGray
        mapBtn.addTarget(self, action: #selector(showLocation), for: .touchUpInside)
        NSLayoutConstraint.activate([
            mapBtn.topAnchor.constraint(equalTo: detlCafe.bottomAnchor, constant: 20),
            mapBtn.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -15),
            //            mapBtn.widthAnchor.constraint(equalTo: mapBtn.widthAnchor)
        ])
        
        view.addSubview(contactBtn)
        contactBtn.translatesAutoresizingMaskIntoConstraints = false
        contactBtn.setImage(UIImage(systemName: "contextualmenu.and.cursorarrow"), for: .normal)
        contactBtn.addTarget(self, action: #selector(contactTbd), for: .touchUpInside)
        NSLayoutConstraint.activate([
            contactBtn.topAnchor.constraint(equalTo: detlCafe.bottomAnchor, constant: 18),
            contactBtn.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -60)
            
        ])
        
        view.addSubview(addComment)
        addComment.translatesAutoresizingMaskIntoConstraints = false
        addComment.setTitle("Add Comment".Localizable(), for: .normal)
        addComment.setTitleColor(.blue, for: .normal)
        addComment.addTarget(self, action: #selector(addCommentTpd), for: .touchUpInside)
        NSLayoutConstraint.activate([
            addComment.topAnchor.constraint(equalTo: detlCafe.bottomAnchor, constant: 13),
            addComment.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30)
            
        ])
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = .white
        tableView.rowHeight = 50
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: addComment.bottomAnchor, constant: 10),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5)
        ])
        
        cosmosView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(cosmosView)
        NSLayoutConstraint.activate([
            cosmosView.topAnchor.constraint(equalTo: detlCafe.bottomAnchor, constant: 13),
            cosmosView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            
        ])
        
    }
    
    @objc func addCommentTpd() {
        let vc = AddComment()
        vc.nameCafe = nameCafe.text!
        present(vc, animated: true, completion: nil)
    }
    
    @objc func showLocation() {
        let vc = PleacOnMap()
        vc.lat = lat
        vc.long = long
        vc.titleCafe = titleCafe
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .flipHorizontal
        
        present(vc, animated: true, completion: nil)
    }
    
    @objc func contactTbd() {
        if MFMailComposeViewController.canSendMail() {
            let vc = MFMailComposeViewController()
            vc.delegate = self
            vc.setSubject("Contact Us / FeedBack")
            vc.setToRecipients(["i-mm-6@hotmail.com"])
            vc.setSubject("Hey there!")
            vc.setMessageBody("Hi, I'd like to know ", isHTML: false)
            
            present(UINavigationController(rootViewController: vc), animated: true)
        }
        else {
            guard let url = URL(string: "https://www.google.com") else {
                return
            }
            let vc = SFSafariViewController(url: url)
            present(vc, animated: true)
            
        }
        
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
        
    }
}

extension ShowDetlsCafe: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let note = comments[indexPath.row]
        cell.textLabel?.text = note.content
        cell.backgroundColor = .systemBrown
        
        return cell
    }
    
    // MARK: - TableView Delegation function (Delete)
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let userID = comments[indexPath.row]
        
        if userID.id == myID {
            if editingStyle == .delete {
                self.db.collection("newComments").document(userID.commentID!).delete()
//                self.tableView.reloadData()
            
            }
//            tableView.reloadData()
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let comment = comments[indexPath.row]
        let vc = AddComment()
        if comment.id == myID {
            vc.commentTF.text = comment.content
            
            self.present(vc, animated: true, completion: nil)
            
        }
    }
}




import UIKit
import MessageUI
import SafariServices

class ShowCafe: UIViewController, MFMailComposeViewControllerDelegate, UINavigationControllerDelegate {
    
    var comments: [CommentCafe] = []

    let cellId = "CommentCell"
    
    lazy var cafeImg1 = UIImageView()
    lazy var cafeImg2 = UIImageView()
    lazy var nameCafe = UILabel()
    lazy var detlCafe = UILabel()
    lazy var mapBtn = UIButton()
    lazy var titComment = UILabel()
    lazy var addComment = UIButton()
    lazy var tableView = UITableView()
    lazy var returnBtn = UIButton()
    lazy var contactBtn = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CommentsService.shared.listenToComments { newNotes in
            self.comments = newNotes
            self.tableView.reloadData()
        }
        
        title = "Cafes".Localizable()
        view.backgroundColor = .white
        
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
        nameCafe.textColor = .gray
        nameCafe.font = .systemFont(ofSize: 15)
        NSLayoutConstraint.activate([
           nameCafe.topAnchor.constraint(equalTo: cafeImg1.bottomAnchor, constant: 5),
            nameCafe.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5)
        ])

        view.addSubview(detlCafe)
        detlCafe.translatesAutoresizingMaskIntoConstraints = false
        detlCafe.font = .boldSystemFont(ofSize: 20)
        detlCafe.numberOfLines = 0
        NSLayoutConstraint.activate([
           detlCafe.topAnchor.constraint(equalTo: nameCafe.bottomAnchor, constant: 8),
           detlCafe.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5),
           detlCafe.widthAnchor.constraint(equalToConstant: 250)
        ])
        
        view.addSubview(mapBtn)
        mapBtn.translatesAutoresizingMaskIntoConstraints = false
        mapBtn.setBackgroundImage(UIImage(systemName: "map"), for: .normal)
        mapBtn.tintColor = .lightGray
        mapBtn.addTarget(self, action: #selector(showLocation), for: .touchUpInside)
        NSLayoutConstraint.activate([
            mapBtn.topAnchor.constraint(equalTo: cafeImg2.bottomAnchor, constant: 25),
            mapBtn.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 25),
            mapBtn.widthAnchor.constraint(equalTo: mapBtn.widthAnchor)
        ])
        
        view.addSubview(contactBtn)
        contactBtn.translatesAutoresizingMaskIntoConstraints = false
        contactBtn.setImage(UIImage(systemName: "contextualmenu.and.cursorarrow"), for: .normal)
        contactBtn.addTarget(self, action: #selector(contactTbd), for: .touchUpInside)
        NSLayoutConstraint.activate([
            contactBtn.topAnchor.constraint(equalTo: mapBtn.bottomAnchor, constant: 10),
            contactBtn.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25)
        
        ])
    
        view.addSubview(titComment)
        titComment.translatesAutoresizingMaskIntoConstraints = false
        titComment.text = "Comments".Localizable()
        titComment.textColor = .systemBlue
        NSLayoutConstraint.activate([
            titComment.topAnchor.constraint(equalTo: detlCafe.bottomAnchor, constant: 20),
            titComment.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15)
        ])

        view.addSubview(addComment)
        addComment.translatesAutoresizingMaskIntoConstraints = false
        addComment.setTitle("Add Comment".Localizable(), for: .normal)
        addComment.setTitleColor(.blue, for: .normal)
        addComment.addTarget(self, action: #selector(addNote), for: .touchUpInside)
        NSLayoutConstraint.activate([
            addComment.topAnchor.constraint(equalTo: detlCafe.bottomAnchor, constant: 13),
            addComment.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50)

        ])
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CommentCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = .white
        tableView.rowHeight = 50
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: addComment.bottomAnchor, constant: 10),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5)
            ])
        
                }
    
    @objc func addNote() {
        present(AddComment(), animated: true, completion: nil)
    }
    
    @objc func showLocation() {
        var loc: Cafe?
        let vc = PleacOnMap()
        
        vc.lat = loc?.latitude
        vc.long = loc?.longitude
        
        present(PleacOnMap(), animated: true, completion: nil)
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

extension ShowCafe: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        as! CommentCell

        let note = comments[indexPath.row]
        cell.textLabel?.text = note.comment
        cell.backgroundColor = .systemBrown
        
        return cell
    }
    
    //MARK:- TableView Delegation function (Delete)
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            let comment = comments[indexPath.row]
            CommentsService.shared.delete(comment: comment)
        }
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let note = comments[indexPath.row]
//
//        let noteVC = AddComment()
//        noteVC.note = note
//
//        present(noteVC, animated: true, completion: nil)
//    }
    
}




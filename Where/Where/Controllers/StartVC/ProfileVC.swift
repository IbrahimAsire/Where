
import UIKit
import FirebaseStorage
import FirebaseAuth
import FirebaseFirestore

class ProfileVC: UIViewController {
    let db = Firestore.firestore().collection("users")
    let imagePicker = UIImagePickerController()
    let storage = Storage.storage()
    
    let containerView: UIView = {
        $0.backgroundColor = .systemGray2
        $0.layer.borderWidth = 0.25
        $0.layer.borderColor = UIColor.white.cgColor
        $0.layer.cornerRadius = 20
        $0.clipsToBounds = true
        return $0
    }(UIView())
    
    let profileImg: UIImageView = {
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 80
        $0.layer.borderColor = UIColor.white.cgColor
        $0.layer.borderWidth = 1
        return $0
    }(UIImageView())
    
    let userNameLbl: UILabel = {
        $0.font = UIFont.systemFont(ofSize: 29, weight: .bold)
        $0.textColor = .white
        $0.textAlignment = .center
        
        return $0
    }(UILabel())
    
    let signOutBtn: UIButton = {
        $0.setTitle("Sign out".Localizable(), for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.addTarget(self, action: #selector(signOutBtnTpd), for: .touchUpInside)
        return $0
    }(UIButton())
    
    let continueBtn: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("Continue".Localizable(), for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.addTarget(self, action: #selector(continueVC), for: .touchUpInside)
        return $0
    }(UIButton())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray2
        navigationItem.hidesBackButton = true
        
        title = "Profile".Localizable()
        self.navigationController?.navigationBar.prefersLargeTitles = false
        readImgFS()
        setUpLbls()
        setupStackView()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchCurrentUser()
        
    }
    
    func setUpLbls() {
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)
        containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        containerView.widthAnchor.constraint(equalToConstant: 325).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 375).isActive = true
        
        profileImg.tintColor  = .white
        profileImg.isUserInteractionEnabled = true
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTpd))
        profileImg.addGestureRecognizer(tapRecognizer)
        
        containerView.addSubview(profileImg)
        profileImg.translatesAutoresizingMaskIntoConstraints = false
        profileImg.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20).isActive = true
        profileImg.widthAnchor.constraint(equalToConstant: 160).isActive = true
        profileImg.heightAnchor.constraint(equalToConstant: 160).isActive = true
        profileImg.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        
        containerView.addSubview(userNameLbl)
        userNameLbl.translatesAutoresizingMaskIntoConstraints = false
        userNameLbl.topAnchor.constraint(equalTo: profileImg.bottomAnchor, constant: 20).isActive = true
        userNameLbl.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
    }
    
    private func setupStackView() {
        
        let stackView = UIStackView(arrangedSubviews: [signOutBtn, continueBtn])
        stackView.backgroundColor = .systemBrown.withAlphaComponent(0.9)
        stackView.layer.cornerRadius = 20
        stackView.clipsToBounds = true
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -45).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 55).isActive = true
    }
    
    @objc func signOutBtnTpd() {
        let vc = Register()
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    @objc func continueVC() {
        let vc = UINavigationController(rootViewController: TabBarMain())
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    func setupImgPicker() {
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true)
    }
    
    @objc func imageTpd() {
        setupImgPicker()
    }
    
    func saveImgFS(url: String, userId: String) {
        db.document(userId).setData([
            "userImageURL": url,
        ], merge: true) { err in
            if let err = err {
                print("Error: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
    
    private func readImgFS(){
        guard let currentUser = Auth.auth().currentUser else {return}
        
        db.whereField("email", isEqualTo: String(currentUser.email!))
            .addSnapshotListener { querySnapshot, error in
                if let e = error {
                    print(e)
                } else {
                    
                    if let snapshotDocs = querySnapshot?.documents {
                        for doc in snapshotDocs {
                            let data = doc.data()
                            
                            if let imageURL = data["userImageURL"] as? String
                            {
                                let httpsReference = self.storage.reference(forURL: imageURL)
                                
                                httpsReference.getData(maxSize: 1 * 1024 * 1024) { data, error in
                                    if let error = error {
                                        print("ERROR GETTING DATA \(error.localizedDescription)")
                                    } else {
                                        DispatchQueue.main.async {
                                            self.profileImg.image = UIImage(data: data!)
                                        }
                                    }
                                }
                                
                            } else {
                                print("error converting data")
                                DispatchQueue.main.async {
                                    self.profileImg.image = UIImage(systemName: "person.fill.badge.plus")
                                }
                            }
                        }
                    }
                }
            }
    }
    
    private func fetchCurrentUser() {
        guard let currentUserName = FirebaseAuth.Auth.auth().currentUser else {return}
        db.whereField("email", isEqualTo: String(currentUserName.email!))
            .addSnapshotListener { (querySnapshot, error) in
                
                if let e = error {
                    print("issue retrieving data from Firestore. \(e)")
                } else {
                    if let snapshotDocs = querySnapshot?.documents {
                        for doc in snapshotDocs {
                            let data = doc.data()
                            if let userName = data["name"] as? String
                            {
                                DispatchQueue.main.async {
                                    self.userNameLbl.text = userName
                                }
                            }
                        }
                    }
                }
            }
    }
}

extension ProfileVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let userPickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {return}
        guard let d: Data = userPickedImage.jpegData(compressionQuality: 0.5) else { return }
        guard let currentUser = Auth.auth().currentUser else {return}
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/png"
        
        let ref = storage.reference().child("UserProfileImages/\(currentUser.email!)/\(currentUser.uid).jpg")
        
        ref.putData(d, metadata: metadata) { (metadata, error) in
            if error == nil {
                ref.downloadURL(completion: { (url, error) in
                    self.saveImgFS(url: "\(url!)", userId: currentUser.uid)
                    
                })
            }else{
                print("error \(String(describing: error))")
            }
        }
        picker.dismiss(animated: true, completion: nil)
    }
}

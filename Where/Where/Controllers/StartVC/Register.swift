
import UIKit
import Firebase
import FirebaseAuth

class Register: UITableViewController {

    let db = Firestore.firestore().collection("users")

    let containerV = UIView()
    let registerBtn = UIButton()
    let nameTF = UITextField()
    let nameSeparatorV = UIView()
    let emailTF = UITextField()
    let emailSeparatorV = UIView()
    let passTf = UITextField()
    let loginLbl = UILabel()
    let loginBtn = UIButton()
    let languageBtn = UIButton()

    let coffeImg: UIImageView = {
        $0.image = UIImage(named: "1")
        return $0
    }(UIImageView())

    let whereImg: UIImageView = {
        $0.image = UIImage(named: "2")
        return $0
    }(UIImageView())

    let stackView: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 5
        return $0
    }(UIStackView())

    override func viewDidLoad() {
        super.viewDidLoad()
//        title = "Register Page"
        setUp()

        view.backgroundColor = .secondarySystemBackground

        containerV.backgroundColor = UIColor(named: "bgColor")
        containerV.layer.cornerRadius = 5
        containerV.layer.masksToBounds = true
        containerV.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerV)
        containerV.addSubview(nameTF)
        containerV.addSubview(nameSeparatorV)
        containerV.addSubview(emailTF)
        containerV.addSubview(emailSeparatorV)
        containerV.addSubview(passTf)

        nameTF.placeholder = "Your Name".Localizable()
        nameTF.textAlignment = .center
        nameTF.translatesAutoresizingMaskIntoConstraints = false
        nameSeparatorV.translatesAutoresizingMaskIntoConstraints = false
        nameSeparatorV.backgroundColor = .lightGray

        emailTF.placeholder = "Email".Localizable()
        emailTF.textAlignment = .center
        emailTF.translatesAutoresizingMaskIntoConstraints = false
        emailSeparatorV.translatesAutoresizingMaskIntoConstraints = false
        emailSeparatorV.backgroundColor = .lightGray

        passTf.placeholder = "Password".Localizable()
        passTf.textAlignment = .center
        passTf.translatesAutoresizingMaskIntoConstraints = false
        passTf.isSecureTextEntry = true

        NSLayoutConstraint.activate([
            containerV.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            containerV.topAnchor.constraint(equalTo: view.topAnchor, constant: 350),
            containerV.widthAnchor.constraint(equalToConstant: 350),
            containerV.heightAnchor.constraint(equalToConstant: 150),

            nameTF.leftAnchor.constraint(equalTo: containerV.leftAnchor, constant: 10),
            nameTF.topAnchor.constraint(equalTo: containerV.topAnchor),
            nameTF.widthAnchor.constraint(equalTo: containerV.widthAnchor),
            nameTF.heightAnchor.constraint(equalTo: containerV.heightAnchor, multiplier: 1/3),

            nameSeparatorV.leftAnchor.constraint(equalTo: containerV.leftAnchor),
            nameSeparatorV.topAnchor.constraint(equalTo: nameTF.bottomAnchor),
            nameSeparatorV.widthAnchor.constraint(equalTo: containerV.widthAnchor),
            nameSeparatorV.heightAnchor.constraint(equalToConstant: 1),

            emailTF.leftAnchor.constraint(equalTo: containerV.leftAnchor, constant: 10),
            emailTF.topAnchor.constraint(equalTo: nameTF.bottomAnchor),
            emailTF.widthAnchor.constraint(equalTo: containerV.widthAnchor),
            emailTF.heightAnchor.constraint(equalTo: containerV.heightAnchor, multiplier: 1/3, constant: 0),
            emailSeparatorV.leftAnchor.constraint(equalTo: containerV.leftAnchor),
            emailSeparatorV.topAnchor.constraint(equalTo: emailTF.bottomAnchor),
            emailSeparatorV.widthAnchor.constraint(equalTo: containerV.widthAnchor),
            emailSeparatorV.heightAnchor.constraint(equalToConstant: 1),

            passTf.leftAnchor.constraint(equalTo: containerV.leftAnchor, constant: 10),
            passTf.topAnchor.constraint(equalTo: emailTF.bottomAnchor),
            passTf.widthAnchor.constraint(equalTo: containerV.widthAnchor),
            passTf.heightAnchor.constraint(equalTo: containerV.heightAnchor, multiplier: 1/3, constant: 0),
        ])

        registerBtn.backgroundColor = .systemBrown
        registerBtn.setTitle("Register".Localizable(), for: .normal)
        registerBtn.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(registerBtn)
        registerBtn.layer.cornerRadius = 10
        registerBtn.addTarget(self, action: #selector(register), for: .touchUpInside)
        NSLayoutConstraint.activate([
            registerBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            registerBtn.topAnchor.constraint(equalTo: containerV.bottomAnchor, constant: 50),
            registerBtn.widthAnchor.constraint(equalToConstant: 150),
            registerBtn.heightAnchor.constraint(equalToConstant: 50)
        ])

        loginLbl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginLbl)
        loginLbl.text = "Do you have your account?".Localizable()
        loginLbl.textColor = .systemBrown
        NSLayoutConstraint.activate([
            loginLbl.topAnchor.constraint(equalTo: registerBtn.bottomAnchor, constant: 30),
            loginLbl.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30)
        ])

        loginBtn.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginBtn)
        loginBtn.addTarget(self, action: #selector(loginGo), for: .touchUpInside)
        loginBtn.setTitle("Login".Localizable(), for: .normal)
        loginBtn.setTitleColor(.systemBrown, for: .normal)
        loginBtn.backgroundColor = .secondarySystemBackground
        NSLayoutConstraint.activate([
            loginBtn.topAnchor.constraint(equalTo: registerBtn.bottomAnchor, constant: 22.5),
            loginBtn.leftAnchor.constraint(equalTo: loginLbl.rightAnchor, constant: 20)
        ])
    
//        languageBtn.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(languageBtn)
//        languageBtn.setTitle("changeLang".Localizable(), for: .normal)
//        languageBtn.addTarget(self, action: #selector(changeLangTpd), for: .touchUpInside)
//        languageBtn.setTitleColor(.systemBrown, for: .normal)
//        NSLayoutConstraint.activate([
//            languageBtn.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
//            languageBtn.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15)
//        ])
        
    }
    
    @objc func changeLangTpd() {
        
        let alertDone = UIAlertController(title: "Change the language!".Localizable(), message: "Must restart to activate".Localizable(), preferredStyle: .alert)
        
        // Create the actions
        let okAction = UIAlertAction(title: "OK".Localizable(), style: UIAlertAction.Style.default){
            UIAlertAction in
            NSLog("OK Pressed")
            let currentLang = Locale.current.languageCode
            let newLanguage = currentLang == "en" ? "ar" : "en"
            UserDefaults.standard.setValue([newLanguage], forKey: "AppleLanguages")
            exit(0)
        }
        let cancelAction = UIAlertAction(title: "No".Localizable(), style: UIAlertAction.Style.cancel) {
            UIAlertAction in
            NSLog("Cancel Pressed")
            return
        }
        
        // Add the actions
        alertDone.addAction(okAction)
        alertDone.addAction(cancelAction)
        
        // Present the controller
        present(alertDone, animated: true, completion: nil)
        alertDone.view.tintColor = .systemRed
        alertDone.view.backgroundColor = .systemRed
        
    }

    @objc func loginGo() {
        navigationController?.pushViewController(Login(), animated: true)
    }
    
    // MARK:- to register a new user and save the info for database
    @objc func register(){
        if let email = emailTF.text, email.isEmpty == false,
           let password = passTf.text, password.isEmpty == false {

            Auth.auth().createUser(withEmail: email, password: password) { result, error in
                if error == nil {
                    self.present(ProfileVC(), animated: true, completion: nil)
                } else {
                    print(error?.localizedDescription ?? "")
                }
                guard let user = result?.user else {return}

                self.db.document(user.uid).setData([
                    "name": self.nameTF.text ?? "",
                    "email": String(user.email!),
                    "userID": user.uid,
                ], merge: true) { err in
                    if let err = err {
                        print("Error writing document: \(err)")
                    } else {
                        print("Document successfully written!")
                    }
                }

            }
        }
    }
}

extension Register {
    func setUp() {
        
        view.addSubview(stackView)
        stackView.addArrangedSubview(whereImg)
        stackView.addArrangedSubview(coffeImg)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
//            stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            stackView.heightAnchor.constraint(equalToConstant: 160),
            whereImg.widthAnchor.constraint(equalToConstant: 180)

        ])
    }
}

// MARK:- to Localizable 
extension String {

    func Localizable() -> String {

        return NSLocalizedString(self, tableName: "Localizable", bundle: .main, value: self,
                                 comment: self)
    }
}


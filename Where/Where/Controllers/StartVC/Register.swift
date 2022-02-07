
import UIKit
import Firebase
import FirebaseAuth

class Register: UITableViewController {
    
    let db = Firestore.firestore().collection("users")
    
    public static func InitUI<Type>(value : Type, block: (_ object: Type) -> Void) -> Type {
       block(value)
       return value
    }
    
    let containerV = InitUI(value: UIView()) {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = UIColor(named: "bgColor")
        $0.layer.cornerRadius = 5
        $0.layer.masksToBounds = true
    }
    
    let registerBtn = InitUI(value: UIButton()) {
        $0.backgroundColor = .systemBrown
        $0.setTitle("Register".Localizable(), for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layer.cornerRadius = 10
        $0.addTarget(self, action: #selector(register), for: .touchUpInside)
    }
    

    let nameTF = InitUI(value: UITextField()) {
        $0.placeholder = "Your Name".Localizable()
        $0.textAlignment = .center
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let emailTF = InitUI(value: UITextField()) {
        $0.placeholder = "Email".Localizable()
        $0.textAlignment = .center
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let passTf = InitUI(value: UITextField()) {
        $0.placeholder = "Password".Localizable()
        $0.textAlignment = .center
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isSecureTextEntry = true
    }
    
    let loginLbl = InitUI(value: UILabel()) {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "Do you have your account?".Localizable()
        $0.textColor = .systemBrown
    }
    
    let loginBtn = InitUI(value: UIButton()) {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.addTarget(self, action: #selector(loginGo), for: .touchUpInside)
        $0.setTitle("Login".Localizable(), for: .normal)
        $0.setTitleColor(.systemBrown, for: .normal)
        $0.backgroundColor = .secondarySystemBackground
    }
    
    let languageBtn = InitUI(value: UIButton()) {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("changeLang".Localizable(), for: .normal)
        $0.addTarget(self, action: #selector(changeLangTpd), for: .touchUpInside)
        $0.setTitleColor(.systemBrown, for: .normal)
    }
    
    let emailSeparatorV = UIView()
    let nameSeparatorV = UIView()
    
    let coffeImg = InitUI(value: UIImageView()) {
        $0.image = UIImage(named: "1")
    }
    
    let whereImg = InitUI(value: UIImageView()) {
        $0.image = UIImage(named: "2")
    }
    
    let stackView = InitUI(value: UIStackView()){
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 5
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
        //        title = "Register Page"
        setUpStackView()
        setUpConstraint()
    }
    
    func setUpConstraint() {
        
        view.addSubview(containerV)
        view.addSubview(registerBtn)
        view.addSubview(loginLbl)
        view.addSubview(loginBtn)
        view.addSubview(languageBtn)
        
        containerV.addSubview(nameTF)
        containerV.addSubview(nameSeparatorV)
        containerV.addSubview(emailTF)
        containerV.addSubview(emailSeparatorV)
        containerV.addSubview(passTf)
        
        nameSeparatorV.translatesAutoresizingMaskIntoConstraints = false
        nameSeparatorV.backgroundColor = .lightGray
        
        emailSeparatorV.translatesAutoresizingMaskIntoConstraints = false
        emailSeparatorV.backgroundColor = .lightGray
        
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
            
            registerBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            registerBtn.topAnchor.constraint(equalTo: containerV.bottomAnchor, constant: 50),
            registerBtn.widthAnchor.constraint(equalToConstant: 150),
            registerBtn.heightAnchor.constraint(equalToConstant: 50),
            
            loginLbl.topAnchor.constraint(equalTo: registerBtn.bottomAnchor, constant: 30),
            loginLbl.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            
            loginBtn.topAnchor.constraint(equalTo: registerBtn.bottomAnchor, constant: 22.5),
            loginBtn.leftAnchor.constraint(equalTo: loginLbl.rightAnchor, constant: 20),
            
            languageBtn.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            languageBtn.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15)
        ])
        
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
        let cancelAction = UIAlertAction(title: "NO".Localizable(), style: .cancel) {
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
    
    // MARK: - to register a new user and save the info for database
    @objc func register(){
        if let email = emailTF.text, email.isEmpty == false,
           let password = passTf.text, password.isEmpty == false {
            
            Auth.auth().createUser(withEmail: email, password: password) { result, error in
                if error == nil {
                    self.navigationController?.pushViewController(ProfileVC(), animated: true)
                    
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
    func setUpStackView() {
        
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

extension Register: UITextViewDelegate {
    
}

// MARK: - to Localizable 
extension String {
    
    func Localizable() -> String {
        
        return NSLocalizedString(
            self, tableName: "Localizable",
            bundle: .main, value: self,
            comment: self)
    }
}

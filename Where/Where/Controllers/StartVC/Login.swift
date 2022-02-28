
import UIKit
import FirebaseAuth

class Login: UIViewController {
    
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
    
    let emailTF: UITextField = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.placeholder = "Type Your Email".Localizable()
        $0.text = "ibra@i.com"
        $0.borderStyle = .roundedRect
        $0.textAlignment = .center
        
        return $0
    }(UITextField())
    
    let passTF: UITextField = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.placeholder = "Type Your Password".Localizable()
        $0.text = "123456"
        $0.borderStyle = .roundedRect
        $0.textAlignment = .center
        $0.isSecureTextEntry = true
        return $0
    }(UITextField())
    
    let loginBtn: UIButton = {
        $0.addTarget(self, action: #selector(login), for: .touchUpInside)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("Login".Localizable(), for: .normal)
        $0.layer.cornerRadius = 10
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .systemBrown
        return $0
    }(UIButton())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
        title = "loginP".Localizable()
        setUpstackView()
        setUpConstraint()
        
    }
    
    private func setUpConstraint() {
        view.addSubview(emailTF)
        view.addSubview(passTF)
        view.addSubview(loginBtn)
        
        NSLayoutConstraint.activate([
            emailTF.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailTF.topAnchor.constraint(equalTo: view.topAnchor, constant: 400),
            
            passTF.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passTF.topAnchor.constraint(equalTo: emailTF.bottomAnchor, constant: 20),
            
            loginBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginBtn.topAnchor.constraint(equalTo: passTF.bottomAnchor, constant: 40),
            loginBtn.widthAnchor.constraint(equalToConstant: 150)
        ])
        
    }
    
    // MARK: - to login user
    @objc func login() {
        if let email = emailTF.text, email.isEmpty == false,
           let password = passTF.text, password.isEmpty == false {
            
            Auth.auth().signIn(withEmail: email, password: password) { result, error in
                
                if let error = error as NSError? {
                    switch AuthErrorCode(rawValue: error.code) {
                    case .wrongPassword:
                        
                        let alert = UIAlertController(title: "Oops!".Localizable(), message: "you entered a wrong password".Localizable(), preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK".Localizable(), style: .cancel, handler: nil))
                        self.present(alert, animated: true)
                        
                    case .invalidEmail:
                        
                        let alert = UIAlertController(title: "Oops!".Localizable(), message: "are sure you typed the email correctly?".Localizable(), preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK".Localizable(), style: .cancel, handler: nil))
                        self.present(alert, animated: true)
                        
                    case .weakPassword:
                        
                        let alert = UIAlertController(title: "Oops!".Localizable(), message: "Your password is weak, please make sure it's strong.".Localizable(), preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK".Localizable(), style: .cancel, handler: nil))
                        self.present(alert, animated: true)
                        
                    default:
                        
                        let alert = UIAlertController(title: "Oops!".Localizable(), message: "\(error.localizedDescription)", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK".Localizable(), style: .cancel, handler: nil))
                        self.present(alert, animated: true)
                        
                    }
                }else{
                    
                    if error == nil {
                        
                        self.navigationController?.pushViewController(ProfileVC(), animated: true)
                    } else {
                        print(error?.localizedDescription)
                    }
                    
                }
                
            }
            
            UIView.animate(withDuration: 2) {
                self.loginBtn.setTitle("Welcome", for: .normal)
                self.loginBtn.titleLabel?.font =  UIFont(name: "GillSans-Italic", size: 42)
                self.view.backgroundColor = .systemBrown
                self.view.layoutIfNeeded()
            }
            
        }
        
    }
    
    private func setUpstackView() {
        
        view.addSubview(stackView)
        stackView.addArrangedSubview(whereImg)
        stackView.addArrangedSubview(coffeImg)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            stackView.heightAnchor.constraint(equalToConstant: 160),
            whereImg.widthAnchor.constraint(equalToConstant: 180)
            
        ])
    }
}


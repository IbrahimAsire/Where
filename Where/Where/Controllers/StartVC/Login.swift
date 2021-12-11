
import UIKit
import FirebaseAuth

class Login: UIViewController {
    
    lazy var coffeImg: UIImageView = {
        $0.image = UIImage(named: "1")
        return $0
    }(UIImageView())
    
    lazy var whereImg: UIImageView = {
        $0.image = UIImage(named: "2")
        return $0
    }(UIImageView())
    
    lazy var stackView: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 5
        return $0
    }(UIStackView())
    
    lazy var emailTF: UITextField = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.placeholder = "Type Your Email"
        $0.borderStyle = .roundedRect
        $0.textAlignment = .center
        
        return $0
    }(UITextField())
    
    lazy var passTF: UITextField = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.placeholder = "Type Your Password"
        $0.borderStyle = .roundedRect
        $0.textAlignment = .center
        $0.isSecureTextEntry = true
        return $0
    }(UITextField())
    
    lazy var loginBtn: UIButton = {
        $0.addTarget(self, action: #selector(login), for: .touchUpInside)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("Login", for: .normal)
        $0.layer.cornerRadius = 10
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .systemBrown
        return $0
    }(UIButton())

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
        title = "Login"
        setUp()
        
        view.addSubview(emailTF)
        NSLayoutConstraint.activate([
            emailTF.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailTF.topAnchor.constraint(equalTo: view.topAnchor, constant: 400),
        ])
        
        view.addSubview(passTF)
        NSLayoutConstraint.activate([
            passTF.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passTF.topAnchor.constraint(equalTo: emailTF.bottomAnchor, constant: 20)
        ])
        
        view.addSubview(loginBtn)
        NSLayoutConstraint.activate([
            loginBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginBtn.topAnchor.constraint(equalTo: passTF.bottomAnchor, constant: 40),
            loginBtn.widthAnchor.constraint(equalToConstant: 150)
    
        ])

    }
    
    @objc func login() {
        if let email = emailTF.text, email.isEmpty == false,
           let password = passTF.text, password.isEmpty == false {
            
            Auth.auth().signIn(withEmail: email, password: password) { result, error in
                
                if let error = error as NSError? {
                    switch AuthErrorCode(rawValue: error.code) {
                    case .wrongPassword:
                        
                        let alert = UIAlertController(title: "Oops!", message: "you entered a wrong password", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                        self.present(alert, animated: true)
                        
                    case .invalidEmail:
                        
                        let alert = UIAlertController(title: "Oops!", message: "are sure you typed the email correctly?", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                        self.present(alert, animated: true)
                        
                    case .weakPassword:
                        
                        let alert = UIAlertController(title: "Oops!", message: "Your password is weak, please make sure it's strong.", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                        self.present(alert, animated: true)
                        
                    default:
                        
                        let alert = UIAlertController(title: "Oops!", message: "\(error.localizedDescription)", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
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
        }
    }
    
    func setUp() {
        
        view.addSubview(stackView)
        stackView.addArrangedSubview(whereImg)
        stackView.addArrangedSubview(coffeImg)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
//            stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            stackView.heightAnchor.constraint(equalToConstant: 160),
            whereImg.widthAnchor.constraint(equalToConstant: 180)
        
        ])
    }
}
    

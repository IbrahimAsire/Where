
import UIKit

class ExitVC: UIViewController {
    
    var appURL = URL(string: "https://itunes.apple.com/app/")!

    var emojiLbl = UILabel()
    var textTF = UITextField()
    var classifyBtn = UIButton()
    let outBTn = UIButton()
    
    let writeReviewBtn: UIButton = {
        $0.setTitle("Sign out".Localizable(), for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.addTarget(self, action: #selector(writeReview), for: .touchUpInside)
        return $0
    }(UIButton())
    
    let shareBtn: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("Continue".Localizable(), for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.addTarget(self, action: #selector(share), for: .touchUpInside)
        return $0
    }(UIButton())

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBrown
        setUp()
        setupStackView()

    }
    
    func setUp() {
        view.addSubview(emojiLbl)
        emojiLbl.translatesAutoresizingMaskIntoConstraints = false
        emojiLbl.font = UIFont.systemFont(ofSize: 80)
        emojiLbl.text = "🧐"
        NSLayoutConstraint.activate([
            emojiLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emojiLbl.topAnchor.constraint(equalTo: view.topAnchor, constant: 100)
        
        ])
        
        view.addSubview(textTF)
        textTF.translatesAutoresizingMaskIntoConstraints = false
        textTF.placeholder = "Write your opinion about App"
        textTF.borderStyle = .roundedRect
        NSLayoutConstraint.activate([
            textTF.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textTF.topAnchor.constraint(equalTo: emojiLbl.bottomAnchor, constant: 40),
            textTF.widthAnchor.constraint(equalToConstant: 250)
        
        ])
        
        view.addSubview(classifyBtn)
        classifyBtn.translatesAutoresizingMaskIntoConstraints = false
        classifyBtn.setTitle("Send your opinion", for: .normal)
        classifyBtn.setTitleColor(.blue, for: .normal)
        classifyBtn.addTarget(self, action: #selector(classifyTpd), for: .touchUpInside)
        NSLayoutConstraint.activate([
            classifyBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            classifyBtn.topAnchor.constraint(equalTo: textTF.bottomAnchor, constant: 60)
        ])
        
        outBTn.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(outBTn)
        outBTn.addTarget(self, action: #selector(signOutBtnTpd),for: .touchUpInside)
        outBTn.setTitle("Go Home".Localizable(), for: .normal)
        NSLayoutConstraint.activate([
            outBTn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            outBTn.topAnchor.constraint(equalTo: classifyBtn.bottomAnchor, constant: 50),
            outBTn.widthAnchor.constraint(equalToConstant: 200),
            outBTn.heightAnchor.constraint(equalToConstant: 80)
        
        ])
    }
    
    private func setupStackView() {
        
        let stackView = UIStackView(arrangedSubviews: [writeReviewBtn, shareBtn])
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
    
    // MARK: - Actions
    
    @objc func writeReview() {
      var components = URLComponents(url: appURL, resolvingAgainstBaseURL: false)
      components?.queryItems = [
        URLQueryItem(name: "action", value: "write-review")
      ]

      guard let writeReviewURL = components?.url else {
        return
      }

      UIApplication.shared.open(writeReviewURL)
    }

    @objc func share() {
      let activityViewController = UIActivityViewController(activityItems: [appURL],
                                                            applicationActivities: nil)

      present(activityViewController, animated: true, completion: nil)
    }
  
    
    @objc func classifyTpd() {
        let textClassifier = TextClassifier()
        
        let prediction = try! textClassifier.prediction(text: textTF.text!)
        print(prediction.label)
        
        switch prediction.label {
        case "Positive":
            emojiLbl.text = "😊"
        case "Negative":
            emojiLbl.text = "😔"
        default:
            emojiLbl.text = "🤨"
            
        }
    }
    
    @objc func signOutBtnTpd() {
        let vc = Register()
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }

}



import UIKit

class ExitVC: UIViewController {
    
    var emojiLbl = UILabel()
    var textTF = UITextField()
    var classifyBtn = UIButton()
    let outBTn = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBrown
        setUp()

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


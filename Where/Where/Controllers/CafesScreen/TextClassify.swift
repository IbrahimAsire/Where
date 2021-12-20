//
//  TextClassifer.swift
//  Where
//
//  Created by ibrahim asiri on 15/05/1443 AH.
//

import UIKit

class TextClassify: UIViewController {
    
    var emojiLbl = UILabel()
    var textTF = UITextField()
    var classifyBtn = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
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
        textTF.placeholder = "type"
        textTF.borderStyle = .roundedRect
        NSLayoutConstraint.activate([
            textTF.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textTF.topAnchor.constraint(equalTo: emojiLbl.bottomAnchor, constant: 40),
            textTF.widthAnchor.constraint(equalToConstant: 250)
        
        ])
        
        view.addSubview(classifyBtn)
        classifyBtn.translatesAutoresizingMaskIntoConstraints = false
        classifyBtn.setTitle("Classify", for: .normal)
        classifyBtn.setTitleColor(.blue, for: .normal)
        classifyBtn.addTarget(self, action: #selector(classifyTpd), for: .touchUpInside)
        NSLayoutConstraint.activate([
            classifyBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            classifyBtn.topAnchor.constraint(equalTo: textTF.bottomAnchor, constant: 60)
        
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

}

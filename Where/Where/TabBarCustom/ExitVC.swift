//
//  ExitVC.swift
//  Where
//
//  Created by ibrahim asiri on 28/04/1443 AH.
//

import UIKit

class ExitVC: UIViewController {
    
    let outBTn = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBrown
        
        outBTn.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(outBTn)
        outBTn.addTarget(self, action: #selector(signOutBtnTbd),for: .touchUpInside)
        outBTn.setTitle("Go Home", for: .normal)
        NSLayoutConstraint.activate([
            outBTn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            outBTn.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            outBTn.widthAnchor.constraint(equalToConstant: 200),
            outBTn.heightAnchor.constraint(equalToConstant: 80)
        
        ])

    }
    
    @objc func signOutBtnTbd() {
        present(Register(), animated: true, completion: nil)
    }

}

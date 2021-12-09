//
//  AddComment.swift
//  Where
//
//  Created by ibrahim asiri on 05/05/1443 AH.
//

import UIKit

class AddComment: UIViewController, UITextViewDelegate {
    
    let commentTF = UITextView()
    let addButton = UIButton()
    
    var note: CommentCafe?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray
        title = "Comment"
        
        setupNameNoteTF()
        setupAddNoteBtn()
        commentTF.text = note?.comment

    }
    
    private func setupNameNoteTF() {
        commentTF.backgroundColor = .systemGray6
        commentTF.layer.cornerRadius = 5
        commentTF.clipsToBounds = true
        commentTF.textAlignment = .left
        commentTF.autocorrectionType = .no
        commentTF.autocapitalizationType = .words
        commentTF.tintColor = .black
        commentTF.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(commentTF)
        commentTF.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        commentTF.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        commentTF.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        commentTF.heightAnchor.constraint(equalToConstant: 600).isActive = true
    }

    private func setupAddNoteBtn() {

        addButton.layer.cornerRadius    = 20
        addButton.layer.borderColor     = UIColor.black.cgColor
        addButton.layer.borderWidth     = 0.55
        addButton.backgroundColor       = .white
        addButton.setTitle("Save", for: .normal)
        addButton.setTitleColor(.black, for: .normal)
        addButton.addTarget(self, action: #selector(addBtnTapped), for: .touchUpInside)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addButton)
        addButton.topAnchor.constraint(equalTo: commentTF.bottomAnchor, constant: 20).isActive = true
        addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        addButton.widthAnchor.constraint(equalToConstant: 300).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
    }
    
    
        
    @objc func addBtnTapped() {
        let note = CommentCafe(id: UUID().uuidString, comment:  commentTF.text)
        CommentsService.shared.updateOrAddNote(comment: note)
        dismiss(animated: true, completion: nil)
    }
}

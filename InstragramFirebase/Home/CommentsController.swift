//
//  CommentsController.swift
//  InstragramFirebase
//
//  Created by jamfly on 2018/3/1.
//  Copyright © 2018年 jamfly. All rights reserved.
//

import UIKit

class CommentsController: UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Comments"
        
        collectionView?.backgroundColor = #colorLiteral(red: 0.423529923, green: 0.6870478392, blue: 0.8348321319, alpha: 1)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    var containerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        containerView.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        
        let submitButton = UIButton(type: .system)
        submitButton.setTitle("Submit", for: .normal)
        submitButton.setTitleColor(.black, for: .normal)
        submitButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        submitButton.addTarget(self, action: #selector(handleSubmit), for: .touchUpInside)
        containerView.addSubview(submitButton)
        submitButton.anchor(
            top: containerView.topAnchor,
            leading: nil,
            bottom: containerView.bottomAnchor,
            trailing: containerView.trailingAnchor,
            padding: .init(top: 0, left: 0, bottom: 0, right: -12),
            size: .init(width: 50, height: 0)
        )

        let textFiled = UITextField()
        textFiled.placeholder = "Enter Comment"
        containerView.addSubview(textFiled)
        textFiled.anchor(
            top: containerView.topAnchor,
            leading: containerView.leadingAnchor,
            bottom: containerView.bottomAnchor,
            trailing: submitButton.leadingAnchor,
            padding: .init(top: 0, left: 12, bottom: 0, right: 0),
            size: .init(width: 0, height: 0)
        )
        
        return containerView
    }()
    
    override var inputAccessoryView: UIView? { return containerView }
    
    override var canBecomeFirstResponder: Bool { return true }
    
    @objc private func handleSubmit() {
        print("Handling submit")
    }
 
}

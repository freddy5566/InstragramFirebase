//
//  LoginViewController.swift
//  InstragramFirebase
//
//  Created by freddy on 04/02/2018.
//  Copyright © 2018 jamfly. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = true
        
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        view.addSubview(signUpButton)
        signUpButton.anchor(
            top: nil,
            leading: view.leadingAnchor,
            bottom: view.bottomAnchor,
            trailing: view.trailingAnchor,
            padding: .init(top: 0, left: 0, bottom: 0, right: 0),
            size: .init(width: 0, height: 50)
        )
    }
    
    private let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Dont have an account?Sign Up.", for: .normal)
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        return button
    }()
    
    @objc private func handleShowSignUp() {
        let signUpController = SignUpViewController()
        navigationController?.pushViewController(signUpController, animated: true)
    }
}

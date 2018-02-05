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
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.anchor(
            top: nil,
            leading: view.leadingAnchor,
            bottom: view.bottomAnchor,
            trailing: view.trailingAnchor,
            padding: .init(top: 0, left: 0, bottom: 0, right: 0),
            size: .init(width: 0, height: 50)
        )
        
        view.addSubview(logoContainerView)
        logoContainerView.anchor(
            top: view.topAnchor,
            leading: view.leadingAnchor,
            bottom: nil,
            trailing: view.trailingAnchor,
            padding: .init(top: 0, left: 0, bottom: 0, right: 0),
            size: .init(width: 0, height: 150)
        )
        
        setupInputFields()
    }
    
    private let logoContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(red: 0, green: 120, blue: 175)
        
        let logo = UIImageView(image: #imageLiteral(resourceName: "Instagram_logo_white"))
        logo.contentMode = .scaleAspectFill
        
        view.addSubview(logo)
        logo.anchor(
            top: nil,
            leading: nil,
            bottom: nil,
            trailing: nil,
            padding: .init(top: 0, left: 0, bottom: 0, right: 0),
            size: .init(width: 200, height: 50)
        )
        logo.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logo.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        return view
    }()
    
    private let dontHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        
        let attributedString = NSMutableAttributedString(string: "Dont have an account?  ", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14), NSAttributedStringKey.foregroundColor: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)])
        
        attributedString.append(NSAttributedString(string: "Sign UP", attributes: [NSAttributedStringKey.foregroundColor: UIColor.rgb(red: 17, green: 154, blue: 237), NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)]
        ))
        
        button.setAttributedTitle(attributedString, for: .normal)
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        return button
    }()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.backgroundColor = UIColor(white: 0, alpha: 0.03)
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 14)
        // textField.addTarget(self, action: #selector(handleTextInput), for: .editingChanged)
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.backgroundColor = UIColor(white: 0, alpha: 0.03)
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.isSecureTextEntry = true
        // textField.addTarget(self, action: #selector(handleTextInput), for: .editingChanged)
        return textField
    }()
    
    private let logInButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.setTitle("Log In", for: .normal)
        button.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        // button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()
    
    private func setupInputFields() {
        let stackView = UIStackView(
            arrangedSubviews: [emailTextField,
                               passwordTextField,
                               logInButton
            ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 10
        
        view.addSubview(stackView)
        
        stackView.anchor(
            top: logoContainerView.bottomAnchor,
            leading: view.leadingAnchor,
            bottom: nil,
            trailing: view.trailingAnchor,
            padding: .init(top: 40, left: 40, bottom: 0, right: -40),
            size: .init(width: 0, height: 140)
        )
    }
    
    @objc private func handleShowSignUp() {
        let signUpController = SignUpViewController()
        navigationController?.pushViewController(signUpController, animated: true)
    }
}

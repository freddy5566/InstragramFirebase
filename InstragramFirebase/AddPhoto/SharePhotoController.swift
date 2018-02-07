//
//  SharePhotoController.swift
//  InstragramFirebase
//
//  Created by freddy on 07/02/2018.
//  Copyright © 2018 jamfly. All rights reserved.
//

import UIKit

class SharePhotoController: UIViewController {
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    var selectedImage: UIImage? {
        didSet {
            imageView.image = selectedImage
        }
    }
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        return iv
    }()
    
    private let textView: UITextView = {
        let tv = UITextView()
        tv.font = UIFont.systemFont(ofSize: 14)
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.rgb(red: 240, green: 240, blue: 240)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .plain, target: self, action: #selector(handleShare))
        
        setupImageAndTextViews()
    }
    
    private func setupImageAndTextViews() {
        let containerView = UIView()
        containerView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        view.addSubview(containerView)
        
        containerView.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            leading: view.leadingAnchor,
            bottom: nil,
            trailing: view.trailingAnchor,
            padding: .init(top: 0, left: 0, bottom: 0, right: 0),
            size: .init(width: 0, height: 100)
        )
        
        containerView.addSubview(imageView)
        imageView.anchor(
            top: containerView.topAnchor,
            leading: containerView.leadingAnchor,
            bottom: containerView.bottomAnchor,
            trailing: nil,
            padding: .init(top: 8, left: 8, bottom: -8, right: 0),
            size: .init(width: 84, height: 0)
        )
        
        containerView.addSubview(textView)
        textView.anchor(
            top: containerView.topAnchor,
            leading: imageView.trailingAnchor,
            bottom: containerView.bottomAnchor,
            trailing: containerView.trailingAnchor,
            padding: .init(top: 0, left: 4, bottom: 0, right: 0),
            size: .init(width: 0, height: 0)
        )
    }
    
    @objc private func handleShare() {
        print("share the photo")
    }
    
    
}

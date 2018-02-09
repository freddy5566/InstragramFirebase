//
//  HomePostCell.swift
//  InstragramFirebase
//
//  Created by jamfly on 2018/2/8.
//  Copyright © 2018年 jamfly. All rights reserved.
//

import UIKit

class HomePostCell: UICollectionViewCell {
    
    var post: Post? {
        didSet {
            guard let postImageURL = post?.imageURL else { return }
            
            photoImageView.loadImage(with: postImageURL)
        }
    }
    
    private let photoImageView: CustomImageView = {
        let iv = CustomImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    private let userProfileImageView: CustomImageView = {
        let iv = CustomImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .blue
        return iv
    }()
    
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "UserName"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    private let optionsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("•••", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    private let likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "like_unselected").withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    private let commentButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "comment").withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    private let sentMessageButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "send2").withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    private let bookmarkButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "ribbon").withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    private let captionLabel: UILabel = {
        let label = UILabel()
        
        let attributedText = NSMutableAttributedString(string: "Username", attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 14)])
        
        attributedText.append(NSAttributedString(string: " Some caption text that will perhaps wrap onto the next line", attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 14)]))
        
        attributedText.append(NSAttributedString(string: "\n\n", attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 4)]))
        
        attributedText.append(NSAttributedString(string: "1 week ago", attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 14), NSAttributedStringKey.foregroundColor: UIColor.gray]))
        
        label.attributedText = attributedText
        label.numberOfLines = 0
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(userProfileImageView)
        addSubview(photoImageView)
        addSubview(userNameLabel)
        addSubview(optionsButton)
        addSubview(captionLabel)
        
        userProfileImageView.anchor(
            top: topAnchor,
            leading: leadingAnchor,
            bottom: nil,
            trailing: nil,
            padding: .init(top: 8, left: 8, bottom: 0, right: 0),
            size: .init(width: 40, height: 40)
        )
        userProfileImageView.layer.cornerRadius = 20
        
        userNameLabel.anchor(
            top: topAnchor,
            leading: userProfileImageView.trailingAnchor,
            bottom: photoImageView.topAnchor,
            trailing: optionsButton.leadingAnchor,
            padding: .init(top: 0, left: 8, bottom: 0, right: 0),
            size: .init(width: 0, height: 0)
        )
        
        optionsButton.anchor(
            top: topAnchor,
            leading: nil,
            bottom: photoImageView.topAnchor,
            trailing: trailingAnchor,
            padding: .init(top: 0, left: 0, bottom: 0, right: 0),
            size: .init(width: 44, height: 0)
        )
        
        photoImageView.anchor(
            top: userProfileImageView.bottomAnchor,
            leading: leadingAnchor,
            bottom: nil,
            trailing: trailingAnchor,
            padding: .init(top: 8, left: 0, bottom: 0, right: 0),
            size: .init(width: 0, height: 0)
        )
        photoImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1).isActive = true
        
        setupActionButtons()
        
        captionLabel.anchor(
            top: likeButton.bottomAnchor,
            leading: leadingAnchor,
            bottom: bottomAnchor,
            trailing: trailingAnchor,
            padding: .init(top: 0, left: 8, bottom: 0, right: -8),
            size: .init(width: 0, height: 0)
        )
        
    }
    
    private func setupActionButtons() {
        let stackView = UIStackView(arrangedSubviews: [likeButton, commentButton, sentMessageButton])
        
        stackView.distribution = .fillEqually
        addSubview(stackView)
        
        stackView.anchor(
            top: photoImageView.bottomAnchor,
            leading: leadingAnchor,
            bottom: nil,
            trailing: nil,
            padding: .init(top: 0, left: 4, bottom: 0, right: 0),
            size: .init(width: 120, height: 50)
        )
        
        addSubview(bookmarkButton)
        
        bookmarkButton.anchor(
            top: photoImageView.bottomAnchor,
            leading: nil,
            bottom: nil,
            trailing: trailingAnchor,
            padding: .init(top: 0, left: 0, bottom: 0, right: 0),
            size: .init(width: 40, height: 50)
        )
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

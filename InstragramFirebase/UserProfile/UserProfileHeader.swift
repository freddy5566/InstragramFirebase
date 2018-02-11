//
//  UserProfileHeader.swift
//  InstragramFirebase
//
//  Created by freddy on 04/02/2018.
//  Copyright © 2018 jamfly. All rights reserved.
//

import UIKit
import Firebase

class UserProfileHeader: UICollectionViewCell {
    
    var user: User? {
        didSet {
            guard let profileImageURL = user?.profileImageURL else { return }
            profileImageView.loadImage(with: profileImageURL)
            
            usernameLabel.text = user?.username
            setupEditFollowButton()
        }
    }
    
    // MARK: -Follow and Edit Button
    private func setupEditFollowButton() {
        guard let currentLoggedInUserId = Auth.auth().currentUser?.uid else { return }
        guard let userId = user?.uid else { return }
        
        if currentLoggedInUserId != userId {
            let ref = Database.database().reference().child("following").child(currentLoggedInUserId).child(userId)
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                if let isFollowing = snapshot.value as? Int, isFollowing == 1 {
                    self.setupUnfollowStyle()
                } else {
                    self.setupFollowStyle()
                }
            }, withCancel: { (error) in
                print("Failed to check if following:", error)
            })
            
            
        }
    }
    
    @objc private func handleEditProfileFollow() {
        guard let currentLoggedInUserId = Auth.auth().currentUser?.uid else { return }
        guard let userId = user?.uid else { return }
        
        if editProfileFollowButton.titleLabel?.text == "Unfollow" {
            Database.database().reference().child("following").child(currentLoggedInUserId).child(userId).removeValue(completionBlock: { (error, ref) in
                if let error = error {
                    print("Failed to unfollow user:", error)
                    return
                }
                print("Successfully unfollow user")
                self.setupFollowStyle()
            })
        } else {
            let ref = Database.database().reference().child("following").child(currentLoggedInUserId)
            let values = [userId: 1]
            ref.updateChildValues(values, withCompletionBlock: { (error, ref) in
                if let error = error {
                    print("Failed to follow user:", error)
                    return
                }
                
                print("Successful follow user:", self.user?.username ?? "")
                self.setupUnfollowStyle()
            })
        }
    }
    
    private func setupUnfollowStyle() {
        
        editProfileFollowButton.setTitle("Unfollow", for: .normal)
        editProfileFollowButton.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        editProfileFollowButton.setTitleColor(.black, for: .normal)
    }
    
    private func setupFollowStyle() {
        editProfileFollowButton.setTitle("Follow", for: .normal)
        editProfileFollowButton.backgroundColor = UIColor.rgb(red: 17, green: 154, blue: 237)
        editProfileFollowButton.setTitleColor(.white, for: .normal)
        editProfileFollowButton.layer.borderColor = UIColor(white: 0, alpha: 0.2).cgColor
    }
    
    private let profileImageView: CustomImageView = {
        let iv = CustomImageView()
        return iv
    }()
    
    private let gridButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "grid"), for: .normal)
        
        return button
    }()
    
    private let bookmarkButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "ribbon"), for: .normal)
        button.tintColor = UIColor(white: 0, alpha: 0.3)
        return button
    }()
    
    private let listButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "list"), for: .normal)
        button.tintColor = UIColor(white: 0, alpha: 0.3)
        return button
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "username"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    private let postsLabel: UILabel = {
        let label = UILabel()
        
        let attrubutedText = NSMutableAttributedString(string: "0\n",
                                                       attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)])
        
        attrubutedText.append(NSAttributedString(string: "posts",
                                                 attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray,
                                                              NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)]
        ))
        label.attributedText = attrubutedText
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let folloersLabel: UILabel = {
        let label = UILabel()
        
        let attrubutedText = NSMutableAttributedString(string: "0\n",
                                                       attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)])
        attrubutedText.append(NSAttributedString(string: "followers",
                                                 attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray,
                                                              NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)]
        ))
        label.attributedText = attrubutedText
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let followingLabel: UILabel = {
        let label = UILabel()
        
        let attrubutedText = NSMutableAttributedString(string: "0\n",
                                                       attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)])
        attrubutedText.append(NSAttributedString(string: "followings",
                                                 attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray,
                                                              NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)]
        ))
        label.attributedText = attrubutedText
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    lazy private var editProfileFollowButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Edit Profile", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 3
        button.addTarget(self, action: #selector(handleEditProfileFollow), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(profileImageView)
        profileImageView.anchor(
            top: topAnchor,
            leading: leadingAnchor,
            bottom: nil,
            trailing: nil,
            padding: .init(top: 12, left: 12, bottom: 0, right: 0),
            size: .init(width: 80, height: 80)
        )
        
        profileImageView.layer.cornerRadius = 40
        profileImageView.layer.masksToBounds = true
        
        setupBottomToobar()
        
        addSubview(usernameLabel)
        usernameLabel.anchor(
            top: profileImageView.bottomAnchor,
            leading: leadingAnchor,
            bottom: gridButton.topAnchor,
            trailing: trailingAnchor,
            padding: .init(top: 4, left: 12, bottom: 0, right: -12),
            size: .init(width: 0, height: 0)
        )
        
        setupUserStatsView()
        
        addSubview(editProfileFollowButton)
        editProfileFollowButton.anchor(
            top: postsLabel.bottomAnchor,
            leading: postsLabel.leadingAnchor,
            bottom: nil,
            trailing: followingLabel.trailingAnchor,
            padding: .init(top: 2, left: 0, bottom: 0, right: 0),
            size: .init(width: 0, height: 34)
        )
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUserStatsView() {
        let stackView = UIStackView(arrangedSubviews: [postsLabel, folloersLabel, followingLabel])
        stackView.distribution = .fillEqually
        
        addSubview(stackView)
        stackView.anchor(
            top: topAnchor,
            leading: profileImageView.trailingAnchor,
            bottom: nil,
            trailing: trailingAnchor,
            padding: .init(top: 12, left: 12, bottom: 0, right: -12),
            size: .init(width: 0, height: 50)
        )
        
    }
    
    private func setupBottomToobar() {
        let topDividerView = UIView()
        topDividerView.backgroundColor = UIColor.lightGray
        
        let bottomDividerView = UIView()
        bottomDividerView.backgroundColor = UIColor.lightGray
        
        let stackView = UIStackView(arrangedSubviews: [gridButton, listButton, bookmarkButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        addSubview(stackView)
        addSubview(topDividerView)
        addSubview(bottomDividerView)
        
        stackView.anchor(
            top: nil,
            leading: leadingAnchor,
            bottom: bottomAnchor,
            trailing: trailingAnchor,
            padding: .init(top: 0, left: 0, bottom: 0, right: 0),
            size: .init(width: 0, height: 50)
        )
        
        topDividerView.anchor(
            top: stackView.topAnchor,
            leading: leadingAnchor,
            bottom: nil,
            trailing: trailingAnchor,
            padding: .init(top: 0, left: 0, bottom: 0, right: 0),
            size: .init(width: 0, height: 0.5)
        )
        
        bottomDividerView.anchor(
            top: stackView.bottomAnchor,
            leading: leadingAnchor,
            bottom: nil,
            trailing: trailingAnchor,
            padding: .init(top: 0, left: 0, bottom: 0, right: 0),
            size: .init(width: 0, height: 0.5)
        )
        
    }
    
    
    
    
}





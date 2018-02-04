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
    
    let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        return iv
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
        backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        profileImageView.layer.cornerRadius = 40
        profileImageView.layer.masksToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var user: User? {
        didSet {
            setupProfileImage()
        }
    }
    
    private func setupProfileImage() {
        guard let profileImageURL = user?.profileImageURL else { return }
        guard let url = URL(string: profileImageURL) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, request, error) in
            
            if let error = error {
                print("Failed to fetch profile image:", error)
            }
            
            guard let data = data else { return }
            let image = UIImage(data: data)
            
            DispatchQueue.main.async {
                self.profileImageView.image = image
            }
        }.resume()
        
        
    }
    
    
    
    
}





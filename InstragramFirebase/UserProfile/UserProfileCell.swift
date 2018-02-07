//
//  UserProfileCell.swift
//  InstragramFirebase
//
//  Created by jamfly on 2018/2/7.
//  Copyright © 2018年 jamfly. All rights reserved.
//

import UIKit

class UserProfileCell: UICollectionViewCell {
    
    var post: Post? {
        didSet {
            guard let imageURL = post?.imageURL else { return }
            guard let url = URL(string: imageURL) else { return }
            
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print("Failed to fetch post", error)
                    return
                }
                
                guard let imageData = data else { return }
                let photoImage = UIImage(data: imageData)
                print("Successfully fetch post")
                DispatchQueue.main.async {
                    self.photoImageView.image = photoImage
                }
            }.resume()
        }
    }
    
    private let photoImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleToFill
        iv.clipsToBounds = true
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(photoImageView)
        photoImageView.anchor(
            top: topAnchor,
            leading: leadingAnchor,
            bottom: bottomAnchor,
            trailing: trailingAnchor
            )
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

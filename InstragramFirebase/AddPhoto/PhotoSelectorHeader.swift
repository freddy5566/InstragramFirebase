//
//  PhotoSelectorHeader.swift
//  InstragramFirebase
//
//  Created by freddy on 06/02/2018.
//  Copyright © 2018 jamfly. All rights reserved.
//

import UIKit

class PhotoSelectorHeader: UICollectionViewCell {
    
    var photoImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
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

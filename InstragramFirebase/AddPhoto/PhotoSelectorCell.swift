//
//  PhotoSelectorCell.swift
//  InstragramFirebase
//
//  Created by jamfly on 2018/2/6.
//  Copyright © 2018年 jamfly. All rights reserved.
//

import UIKit

class PhotoSelectorCell: UICollectionViewCell {
    
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

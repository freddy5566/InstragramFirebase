//
//  PreviewPhotoContainerView.swift
//  InstragramFirebase
//
//  Created by freddy on 23/02/2018.
//  Copyright © 2018 jamfly. All rights reserved.
//

import UIKit
import Photos

class PreviewPhotoContainerView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(previewImageView)
        previewImageView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        
        addSubview(cancleButton)
        cancleButton.anchor(
            top: topAnchor,
            leading: leadingAnchor,
            bottom: nil,
            trailing: nil,
            padding: .init(top: 12, left: 12, bottom: 0, right: 0),
            size: .init(width: 50, height: 50)
        )
        
        addSubview(saveButton)
        saveButton.anchor(
            top: nil,
            leading: leadingAnchor,
            bottom: bottomAnchor,
            trailing: nil,
            padding: .init(top: 0, left: 24, bottom: -24, right: 0),
            size: .init(width: 50, height: 50)
        )
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let previewImageView: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    
    private let cancleButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "cancel_shadow").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleCancle), for: .touchUpInside)
        return button
    }()
    
    @objc private func handleCancle() {
        self.removeFromSuperview()
    }
    
    private let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "save_shadow").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleSave), for: .touchUpInside)
        return button
    }()
    
    @objc private func handleSave() {
        
        guard let previewImage = previewImageView.image else { return }
        
        let libery = PHPhotoLibrary.shared()
        libery.performChanges({
            PHAssetChangeRequest.creationRequestForAsset(from: previewImage)
        }) { (success, error) in
            if let error = error {
                print("Failed to save image to photo library:", error)
                return
            }
            
            print("Successfully saved image to library")
            
            DispatchQueue.main.async {
                let saveLabel = UILabel()
                saveLabel.text = "Save Successfully"
                saveLabel.font = UIFont.boldSystemFont(ofSize: 18)
                saveLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                saveLabel.numberOfLines = 0
                saveLabel.backgroundColor = UIColor(white: 0, alpha: 0.3)
                saveLabel.textAlignment = .center
                saveLabel.frame = CGRect(x: 0, y: 0, width: 150, height: 80)
                saveLabel.center = self.center
                
                self.addSubview(saveLabel)
                
                saveLabel.layer.transform = CATransform3DMakeScale(0, 0, 0)
                
                UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
                    saveLabel.layer.transform = CATransform3DMakeScale(1, 1, 1)
                }, completion: { (_) in
                    UIView.animate(withDuration: 0.5, delay: 0.75, options: .curveEaseOut, animations: {
                        saveLabel.layer.transform = CATransform3DMakeScale(0.1, 0.1, 0.1)
                        saveLabel.alpha = 0
                    }, completion: { (_) in
                        
                        saveLabel.removeFromSuperview()
                    })
                })
            }
            
        }
        
    }
    
    
    
}

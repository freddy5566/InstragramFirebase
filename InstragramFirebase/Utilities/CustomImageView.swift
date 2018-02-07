//
//  CustomImageView.swift
//  InstragramFirebase
//
//  Created by freddy on 07/02/2018.
//  Copyright © 2018 jamfly. All rights reserved.
//

import UIKit

class CustomImageView: UIImageView {
    
    private var lastURLUsedToLoadImage: String?
    
    func loadImage(with imageURL: String) {
        print("Loading image...")
        
        lastURLUsedToLoadImage = imageURL
        
        guard let url = URL(string: imageURL) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Failed to fetch post image:", error)
                return
            }
            
            if url.absoluteString != self.lastURLUsedToLoadImage {
                return
            }
            
            guard let imageData = data else { return }
            
            let phpotoImage = UIImage(data: imageData)
            
            DispatchQueue.main.async {
                self.image = phpotoImage
            }
            
        }.resume()
    }
    
    
    
    
}

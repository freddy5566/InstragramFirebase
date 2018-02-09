//
//  CustomImageView.swift
//  InstragramFirebase
//
//  Created by freddy on 07/02/2018.
//  Copyright © 2018 jamfly. All rights reserved.
//

import UIKit

var imageCache = [String: UIImage]()

class CustomImageView: UIImageView {
    
    private var lastURLUsedToLoadImage: String?
    
    func loadImage(with imageURL: String) {
        print("Loading image...")

        lastURLUsedToLoadImage = imageURL
        
        if let cachedImage = imageCache[imageURL] {
            self.image = cachedImage
            return
        }
        
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
            
            let photoImage = UIImage(data: imageData)
            
            imageCache[url.absoluteString] = photoImage
            
            DispatchQueue.main.async {
                self.image = photoImage
            }
            
            }.resume()
    }
    
}
    
    
    


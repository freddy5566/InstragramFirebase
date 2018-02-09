//
//  extensions.swift
//  InstragramFirebase
//
//  Created by freddy on 03/02/2018.
//  Copyright © 2018 jamfly. All rights reserved.
//

import UIKit
import Firebase

extension UIColor {
    
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red / 255, green: green / 255, blue: blue / 255, alpha: 1)
    }
    
}

extension UIView {
    
    func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        
        if let leading = leading {
            self.leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: padding.bottom).isActive = true
        }
        
        if let trailing = trailing {
            self.trailingAnchor.constraint(equalTo: trailing, constant: padding.right).isActive = true
        }
        
        if size.height != 0 {
            self.heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
        
        if size.width != 0 {
            self.widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
    }
}

extension Database {
    
    class func fetchUserWith(uid: String, completion: @escaping (User) -> ()) {
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with:  { (snapeshot) in
            
            guard let userDict = snapeshot.value as? [String: Any] else { return }
 
            let user = User(uid: uid, dictionary: userDict)
            completion(user)
            
            }) { (err) in
                print("Failed to fetch posts:", err)
            }
    }
}


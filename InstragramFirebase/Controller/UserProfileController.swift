//
//  UserProfileController.swift
//  InstragramFirebase
//
//  Created by freddy on 04/02/2018.
//  Copyright © 2018 jamfly. All rights reserved.
//

import UIKit
import Firebase

class UserProfileController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        fetchUser()
    }
    
    private func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        Database.database().reference().child("users").child(uid).observeSingleEvent(
            of: .value,
            with: { (snapshot) in
                
                guard let dict = snapshot.value as? [String: Any] else { return }
                
                let username = dict["username"] as? String
                self.navigationItem.title = username
                
        }) { (error) in
            print("Failed to fetch user:", error)
        }
    }
    
}

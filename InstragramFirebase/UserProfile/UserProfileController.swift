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
    
    private let headerID = "headerID"
    private let cellID = "cellID"
    private var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        fetchUser()
        
        collectionView?.register(UserProfileHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerID)
        
        collectionView?.register(UserProfileCell.self, forCellWithReuseIdentifier: cellID)
        
        setupLogOutButton()
        fetchPosts()
    }
    
    // MARK: fetch post
    private var posts = [Post]()
    
    private func fetchPosts() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let ref = Database.database().reference().child("posts").child(uid)
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let dictionaries = snapshot.value as? [String: Any] else { return }
            dictionaries.forEach({ (ket, value) in
                guard let dict = value as? [String: Any] else { return }
                
                let post = Post(postDic: dict)
                self.posts.append(post)
            })
            self.collectionView?.reloadData()
        }) { (error) in
            print("Failed to fetch posts:", error)
        }
    }
    
    // MARK: -Log Out
    private func setupLogOutButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "gear").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleLogOut))
    }
    
    @objc private func handleLogOut() {
        let alerController = UIAlertController()
        
        alerController.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { (_) in
            do {
                try Auth.auth().signOut()
                
                let loginController = LoginViewController()
                let navController = UINavigationController(rootViewController: loginController)
                self.present(navController, animated: true, completion: nil)
                
            } catch let sigOutError {
                print("Failed to sign out:", sigOutError)
            }
        }))
        
        alerController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alerController, animated: true, completion: nil)
    }
    
    // MARK: - interagrams
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 2) / 3
        return CGSize(width: width, height: width)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! UserProfileCell
        cell.post = posts[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    // MARK: -header
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerID, for: indexPath) as! UserProfileHeader
        header.user = user
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
    
    
    // MARK: -fetch data
    private func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        Database.database().reference().child("users").child(uid).observeSingleEvent(
            of: .value,
            with: { (snapshot) in
                
                guard let dict = snapshot.value as? [String: Any] else { return }
                
                self.user = User(dictionary: dict)
                
                self.navigationItem.title = self.user?.username
                self.collectionView?.reloadData()
                
        }) { (error) in
            print("Failed to fetch user:", error)
        }
    }
    
}

struct User {
    
    let username: String
    let profileImageURL: String
    
    init(dictionary: [String: Any]) {
        self.username = dictionary["username"] as? String ?? ""
        self.profileImageURL = dictionary["profileImageURL"] as? String ?? ""
    }
    
    
}





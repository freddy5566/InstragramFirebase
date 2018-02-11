//
//  HomeController.swift
//  InstragramFirebase
//
//  Created by jamfly on 2018/2/8.
//  Copyright © 2018年 jamfly. All rights reserved.
//

import UIKit
import Firebase

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private let cellID = "cellID"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        collectionView?.register(HomePostCell.self, forCellWithReuseIdentifier: cellID)
        
        setupNavigationItem()
        fetchFolloingUsersIds()
    }
    
    private func setupNavigationItem() {
        navigationItem.titleView = UIImageView(image: #imageLiteral(resourceName: "logo2"))
    }
    
    // MARK: -posts
    var posts = [Post]()
    
//    private func fetchPosts() {
//        guard let uid = Auth.auth().currentUser?.uid else { return }
//
//        Database.fetchUserWith(uid: uid) { (user) in
//            self.fetchPostWith(user: user)
//        }
//    }
    
    private func fetchFolloingUsersIds() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        Database.database().reference().child("following").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            
            guard let userIdDictonary = snapshot.value as? [String: Any] else { return }
            
            userIdDictonary.forEach({ (key, value) in
                Database.fetchUserWith(uid: key, completion: { (user) in
                    self.fetchPostWith(user: user)
                })
            })
            
        }) { (error) in
            print("Failed to fetch folloing user ids:", error)
        }
    }
    
    private func fetchPostWith(user: User) {
        let ref = Database.database().reference().child("posts").child(user.uid)
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let dictionaries = snapshot.value as? [String: Any] else { return }
            
            dictionaries.forEach({ (key, value) in
                guard let dictionary = value as? [String: Any] else { return }
                let post = Post(user: user, postDic: dictionary)
                self.posts.append(post)
            })
            
            self.posts.sort(by: { (post1, post2) -> Bool in
                return post1.creationDate .compare(post2.creationDate) == .orderedDescending
            })
            
            self.collectionView?.reloadData()
        }) { (error) in
            print("Faoled to fetch posts: ", error)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width
        var height = width
        height += 40 + 8 + 8 // username
        height += 50 // actions button
        height += 60 // posts text
        return CGSize(width: width, height: height)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! HomePostCell
        cell.post = posts[indexPath.item]
        return cell
    }
    
}

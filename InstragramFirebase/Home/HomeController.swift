//
//  HomeController.swift
//  InstragramFirebase
//
//  Created by jamfly on 2018/2/8.
//  Copyright © 2018年 jamfly. All rights reserved.
//

import UIKit
import Firebase

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout, HomePostCellDelgate {
    
    private let cellID = "cellID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleUpdateFeed), name: SharePhotoController.updateFeedNotificationName, object: nil)
        
        collectionView?.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        collectionView?.register(HomePostCell.self, forCellWithReuseIdentifier: cellID)
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        collectionView?.refreshControl = refreshControl
        
        setupNavigationItem()
        
        handleRefresh()
    }
    
    @objc private func handleUpdateFeed() {
        handleRefresh()
    }
    
    @objc private func handleRefresh() {
        posts.removeAll()
        fetchFolloingUsersIds()
    }
    
    private func setupNavigationItem() {
        navigationItem.titleView = UIImageView(image: #imageLiteral(resourceName: "logo2"))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: #imageLiteral(resourceName: "camera3").withRenderingMode(.alwaysOriginal),
            style: .plain,
            target: self,
            action: #selector(handleCamara)
        )
    }
    
    @objc private func handleCamara() {
        let camaraCon = CameraController()
        
        present(camaraCon, animated: true, completion: nil)
    }
    
    // MARK: -posts
    var posts = [Post]()
    
    private func fetchFolloingUsersIds() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Database.database().reference().child("following").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            
            guard let userIdDictonary = snapshot.value as? [String: Any] else {
                self.collectionView?.refreshControl?.endRefreshing()
                self.collectionView?.reloadData()
                return
                
            }
            
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
            
            self.collectionView?.refreshControl?.endRefreshing()
        
            dictionaries.forEach({ (key, value) in
                guard let dictionary = value as? [String: Any] else { return }
                var post = Post(user: user, postDic: dictionary)
                post.id = key
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
        
        cell.delegate = self
        
        return cell
    }
    
    func didTapComment(post: Post) {
        print("Message coming from homecontroller")
        print(post.caption)
        let commentsController = CommentsController(collectionViewLayout: UICollectionViewFlowLayout())
        commentsController.post = post
        navigationController?.pushViewController(commentsController, animated: true)
    }
    
    
}

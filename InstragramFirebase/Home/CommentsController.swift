//
//  CommentsController.swift
//  InstragramFirebase
//
//  Created by jamfly on 2018/3/1.
//  Copyright © 2018年 jamfly. All rights reserved.
//

import UIKit
import Firebase

class CommentsController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var post: Post?
    private let cellID = "cellID"
    private var comments = [Comment]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Comments"
        
        collectionView?.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        collectionView?.alwaysBounceVertical = true
        collectionView?.keyboardDismissMode = .interactive
        
        collectionView?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: -50, right: 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: -50, right: 0)
        
        collectionView?.register(CommentCell.self, forCellWithReuseIdentifier: cellID)
        
        fetchComments()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return comments.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        let dummyCell = CommentCell(frame: frame)
        dummyCell.comment = comments[indexPath.item]
        dummyCell.layoutIfNeeded()
        
        let targetSize = CGSize(width: view.frame.width, height: 1000)
        let estimatedSize = dummyCell.systemLayoutSizeFitting(targetSize)
        
        let height = max(40 + 8 + 8, estimatedSize.height)
        
        return CGSize(width: view.frame.width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! CommentCell
        cell.comment = comments[indexPath.item]
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    private func fetchComments() {
        guard let postID = post?.id else { return }
        let ref = Database.database().reference().child("comments").child(postID)
        ref.observe(.childAdded, with: { (snapshop) in
            
            guard let dic = snapshop.value as? [String: Any] else { return }
            guard let uid = dic["uid"] as? String else { return }
            
            Database.fetchUserWith(uid: uid, completion: { (user) in
                
                let comment = Comment(user: user, dictionary: dic)
                self.comments.append(comment)
                self.collectionView?.reloadData()
            })
            
            
        }) { (err) in
            print("Failed to fetch comments", err)
        }
    }
    
    private lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        containerView.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        
        let submitButton = UIButton(type: .system)
        submitButton.setTitle("Submit", for: .normal)
        submitButton.setTitleColor(.black, for: .normal)
        submitButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        submitButton.addTarget(self, action: #selector(handleSubmit), for: .touchUpInside)
        containerView.addSubview(submitButton)
        submitButton.anchor(
            top: containerView.topAnchor,
            leading: nil,
            bottom: containerView.bottomAnchor,
            trailing: containerView.trailingAnchor,
            padding: .init(top: 0, left: 0, bottom: 0, right: -12),
            size: .init(width: 50, height: 0)
        )

        containerView.addSubview(commentTextField)
        commentTextField.anchor(
            top: containerView.topAnchor,
            leading: containerView.leadingAnchor,
            bottom: containerView.bottomAnchor,
            trailing: submitButton.leadingAnchor,
            padding: .init(top: 0, left: 12, bottom: 0, right: 0),
            size: .init(width: 0, height: 0)
        )
        
        return containerView
    }()
    
    private let commentTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Comment"
        return textField
    }()
    
    
    @objc private func handleSubmit() {
        print("Insert comment: ", commentTextField.text ?? "")
        print("Inserting comment:", commentTextField.text ?? "")
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let postID = self.post?.id ?? ""
        let value: [String: Any] = ["text": commentTextField.text ?? "", "currentDate": Date().timeIntervalSince1970, "uid": uid]
        
        Database.database().reference().child("comments").child(postID).childByAutoId().updateChildValues(value) { (error, reference) in
            
            if let error = error {
                print("Failed to insert comment:", error)
                return
            }
            print("Successfully insert comment.")
        }
        commentTextField.text = ""
        
    }
    
    override var inputAccessoryView: UIView? { return containerView }
    
    override var canBecomeFirstResponder: Bool { return true }
    
 
}

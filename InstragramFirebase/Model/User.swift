//
//  User.swift
//  InstragramFirebase
//
//  Created by freddy on 09/02/2018.
//  Copyright © 2018 jamfly. All rights reserved.
//

import Foundation

struct User {
    
    let username: String
    let profileImageURL: String
    let uid: String
    init(uid: String, dictionary: [String: Any]) {
        self.username = dictionary["username"] as? String ?? ""
        self.profileImageURL = dictionary["profileImageURL"] as? String ?? ""
        self.uid = uid
    }
}

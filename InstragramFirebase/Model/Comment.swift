//
//  Comment.swift
//  InstragramFirebase
//
//  Created by freddy on 2018/5/1.
//  Copyright © 2018 jamfly. All rights reserved.
//

import Foundation

struct Comment {
    
    let user: User
    
    let text: String
    let uid: String
    
    init(user: User, dictionary: [String: Any]) {
        self.user = user
        self.text = dictionary["text"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
    }
    
    
}

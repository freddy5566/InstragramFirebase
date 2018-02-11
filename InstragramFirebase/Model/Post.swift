//
//  Post.swift
//  InstragramFirebase
//
//  Created by jamfly on 2018/2/7.
//  Copyright © 2018年 jamfly. All rights reserved.
//

import Foundation

struct Post {
    
    let user: User
    let imageURL: String
    let caption: String
    let creationDate: Date
    
    init(user: User, postDic: [String: Any]) {
        self.caption = postDic["caption"] as? String ?? ""
        self.imageURL = postDic["imageURL"] as? String ?? ""
        self.user = user
        
        let secondsFrom1970 = postDic["creationDate"] as? Double ?? 0
        self.creationDate = Date(timeIntervalSince1970: secondsFrom1970)
    }
    
}

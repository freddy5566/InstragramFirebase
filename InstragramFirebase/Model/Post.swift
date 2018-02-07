//
//  Post.swift
//  InstragramFirebase
//
//  Created by jamfly on 2018/2/7.
//  Copyright © 2018年 jamfly. All rights reserved.
//

import Foundation

struct Post {
    
    let imageURL: String
    
    init(postDic: [String: Any]) {
        self.imageURL = postDic["imageURL"] as? String ?? ""
    }
    
}

//
//  StaticContent.swift
//  handle
//
//  Created by Alex Lundquist on 5/4/19.
//  Copyright © 2019 Alex Lundquist. All rights reserved.
//

import UIKit

class StaticContent {
    static let shared = StaticContent()
    private init() {}
    
    
    var postContent: [PostContent] = []
    
    func createPost(caption: String, crPhoto: UIImage) -> PostContent{
        let myPost = PostContent(fbCaption: caption, fbPhoto: crPhoto)
        return myPost
    }
}

struct PostContent {
    let fbCaption: String?
    let fbPhoto: UIImage?
}

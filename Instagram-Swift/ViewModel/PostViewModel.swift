//
//  PostViewModel.swift
//  Instagram-Swift
//
//  Created by hakkı can şengönül on 30.10.2022.
//

import Foundation

struct PostViewModel {
    private let post: Post
    
    var imageUrl: URL?{ return URL(string: post.imageUrl) }
    
    var caption: String?{ return post.caption }
    
    var likes:Int?{ return post.likes }
    
    init(post: Post) {
        self.post = post
    }
}

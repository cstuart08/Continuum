//
//  PostController.swift
//  Continuum
//
//  Created by Apps on 8/27/19.
//  Copyright © 2019 Apps. All rights reserved.
//

import UIKit

class PostController {
    
    // MARK: - Singleton
    static let shared = PostController()
    
    var posts: [Post] = []
    
    func addComment(text: String, post: Post, completion: @escaping (Comment) -> Void) {
        let comment = Comment(text: text, post: post)
        post.comments.append(comment)
    }
    
    func createPostWith(image: UIImage, caption: String, completion: @escaping (Post?) -> Void) {
        let post = Post(photo: image, caption: caption)
        posts.append(post)
    }
    
}

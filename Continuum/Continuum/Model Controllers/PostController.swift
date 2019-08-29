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
    
    var posts: [Post] = [
    Post(photo: #imageLiteral(resourceName: "Paul_McCartney_in_October_2018"), caption: "I say hello"),
    Post(photo: #imageLiteral(resourceName: "John_Lennon_1969_(cropped)"), caption: "You say goodbye")
    ]
    
    func addComment(text: String, post: Post, completion: @escaping (Comment) -> Void) {
        let comment = Comment(text: text, post: post)
        post.comments.append(comment)
    }
    
    func createPostWith(image: UIImage, caption: String, completion: @escaping (Post?) -> Void) {
        let post = Post(photo: image, caption: caption)
        posts.append(post)
    }
    
}

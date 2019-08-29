//
//  PostController.swift
//  Continuum
//
//  Created by Apps on 8/27/19.
//  Copyright © 2019 Apps. All rights reserved.
//

import UIKit
import CloudKit

class PostController {
    
    // MARK: - Singleton
    static let shared = PostController()
    let publicDB = CKContainer.default().publicCloudDatabase
    
    var posts: [Post] = []
    
    func addComment(text: String, post: Post, completion: @escaping (Comment?) -> Void) {
        let comment = Comment(text: text, post: post)
        let commentRecord = CKRecord(comment: comment)
        post.comments.append(comment)
        
        publicDB.save(commentRecord) { (_, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion(nil)
                return
            }
            completion(comment)
            return
        }
    }
    
    func createPostWith(image: UIImage, caption: String, completion: @escaping (Post?) -> Void) {
        let post = Post(photo: image, caption: caption)
        let postRecord = CKRecord(post: post)
        posts.append(post)
        
        publicDB.save(postRecord) { (_, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion(nil)
                return
            }
            completion(post)
            return
        }
    }
}

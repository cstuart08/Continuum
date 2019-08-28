//
//  PostTableViewCell.swift
//  Continuum
//
//  Created by Apps on 8/27/19.
//  Copyright © 2019 Apps. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var postCaptionLable: UILabel!
    @IBOutlet weak var postCommentLabel: UILabel!
    
    var post: Post? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        guard let post = post else { return }
        postImageView.image = post.photo
        postCaptionLable.text = post.caption
        postCommentLabel.text = "\(post.comments.count)"
    }
    
}

//
//  Comment.swift
//  Continuum
//
//  Created by Apps on 8/27/19.
//  Copyright © 2019 Apps. All rights reserved.
//

import Foundation

class Comment {
    
    let text: String
    let timestamp: Date
    weak var post: Post?
    
    init(text: String, timestamp: Date = Date(), post: Post?) {
        self.text = text
        self.timestamp = timestamp
        self.post = post
    }
}

extension Comment: Equatable {
    static func == (lhs: Comment, rhs: Comment) -> Bool {
        return lhs.text == rhs.text && lhs.timestamp == rhs.timestamp && lhs.post == rhs.post
    }
}

extension Comment: SearchableRecord {
    func matches(searchTerm: String) -> Bool {
        if text.lowercased().contains(searchTerm.lowercased()) {
            return true
        } else {
            return false
        }
    }
}

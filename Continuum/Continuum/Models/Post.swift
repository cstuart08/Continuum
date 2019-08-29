//
//  Post.swift
//  Continuum
//
//  Created by Apps on 8/27/19.
//  Copyright © 2019 Apps. All rights reserved.
//

import UIKit
import CloudKit

struct Constants {
    static let TypeKey = "Post"
    static let timestampKey = "timestampKey"
    static let captionKey = "caption"
    static let commentsKey = "comments"
    static let photoKey = "photo"
}

class Post {
    
    var photoData: Data?
    let timestamp: Date
    let caption: String
    var comments: [Comment]
    var recordID: CKRecord.ID
    
    var imageAsset: CKAsset? {
        get {
            let tempDirectory = NSTemporaryDirectory()
            let tempDirectoryURL = URL(fileURLWithPath: tempDirectory)
            let fileURL = tempDirectoryURL.appendingPathComponent(UUID().uuidString).appendingPathExtension("jpg")
            do {
                try photoData?.write(to: fileURL)
            } catch {
                print("error...")
            }
            return CKAsset(fileURL: fileURL)
        }
    }
    
    var photo: UIImage? {
        get {
            guard let data = self.photoData else { return nil }
            return UIImage(data: data)
        }
        set {
            photoData = newValue?.jpegData(compressionQuality: 0.5)
        }
    }
    
    init(photo: UIImage?, caption: String, timestamp: Date = Date(), comments: [Comment] = [], recordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString)) {
        self.caption = caption
        self.timestamp = timestamp
        self.comments = comments
        self.recordID = recordID
        self.photo = photo
    }
    
    init?(ckRecord: CKRecord) {
        guard let imageAsset = ckRecord[Constants.photoKey] as? CKAsset,
            let caption = ckRecord[Constants.captionKey] as? String,
            let timestamp = ckRecord[Constants.timestampKey] as? Date else { return nil }
        
        guard let url = imageAsset.fileURL else { return nil }
        do {
        self.photoData = try Data(contentsOf: url)
        } catch {
            print("error getting photo data from imageAsset.fileURL \(error)")
        }
        self.caption = caption
        self.timestamp = timestamp
        self.comments = []
        self.recordID = ckRecord.recordID
    }
    
}
extension CKRecord {
    convenience init(post: Post) {
        self.init(recordType: Constants.TypeKey, recordID: post.recordID)
        self.setValue(post.caption, forKey: Constants.captionKey)
        self.setValue(post.timestamp, forKey: Constants.timestampKey)
        self.setValue(post.imageAsset, forKey: Constants.photoKey)
    }
}

extension Post: Equatable {
    static func == (lhs: Post, rhs: Post) -> Bool {
        return lhs.photoData == rhs.photoData && lhs.timestamp == rhs.timestamp && lhs.caption == rhs.caption && lhs.comments == rhs.comments
    }
}

extension Post: SearchableRecord {
    func matches(searchTerm: String) -> Bool {
        if caption.lowercased().contains(searchTerm.lowercased()) {
            return true
        } else {
            return false
        }
    }
}

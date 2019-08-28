//
//  PostDetailTableViewController.swift
//  Continuum
//
//  Created by Apps on 8/27/19.
//  Copyright © 2019 Apps. All rights reserved.
//

import UIKit

class PostDetailTableViewController: UITableViewController {
    
    var post: Post? {
        didSet {
            updateViews()
        }
    }
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func updateViews() {
        loadViewIfNeeded()
        guard let post = post else { return }
        photoImageView.image = post.photo
        tableView.reloadData()
    }
    
    func presentAlertController() {
        let alertController = UIAlertController(title: "Comment", message: "Write your comment:", preferredStyle: .alert)
        
        alertController.addTextField { (textField) in
            textField.placeholder = "What's your thoughts on this picture?"
        }
        
        let alertActionAddComment = UIAlertAction(title: "OK", style: .default) { (_) in
            guard let commentText = alertController.textFields?.first?.text else { return }
            guard let post = self.post else { return }
            
            if commentText != "" {
                
                PostController.shared.addComment(text: commentText, post: post, completion: { (success) in
                })
                self.tableView.reloadData()
            }
        }
        let alertActionCancelComment = UIAlertAction(title: "Cancel", style: .destructive)
        
        alertController.addAction(alertActionAddComment)
        alertController.addAction(alertActionCancelComment)
        present(alertController, animated: true)
    }
    
    @IBAction func commentButtonTapped(_ sender: Any) {
        presentAlertController()

    }
    
    @IBAction func shareButtonTapped(_ sender: Any) {
    }
    
    @IBAction func followPostButtonTapped(_ sender: Any) {
    }
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let postCount = post?.comments.count else { return 0 }
        return postCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath)
        guard let post = post else { return UITableViewCell() }
        let comment = post.comments[indexPath.row]
        let date = DateHelper.sharedDateHelper.mediumDate(timestamp: post.timestamp)
        
        cell.textLabel?.text = comment.text
        cell.detailTextLabel?.text = date
        
        return cell
    }
}

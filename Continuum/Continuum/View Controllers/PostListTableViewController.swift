//
//  PostListTableViewController.swift
//  Continuum
//
//  Created by Apps on 8/27/19.
//  Copyright © 2019 Apps. All rights reserved.
//

import UIKit

class PostListTableViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var results: [Post] = []
    var isSearching: Bool = false
    
    var dataSource: [Post] {
        return isSearching ? results : PostController.shared.posts
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tableView.reloadData()
        results = PostController.shared.posts
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        var newResults: [Post] = []
        guard let searchTerm = searchBar.text else { return }
        for post in PostController.shared.posts {
            if post.matches(searchTerm: searchTerm) {
                newResults.append(post)
            }
        }
        results = newResults
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        results = PostController.shared.posts
        tableView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isSearching = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        isSearching = false
    }
    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as? PostTableViewCell else { return UITableViewCell() }
        
        let post = dataSource[indexPath.row]
        cell.post = post
        
        return cell
    }
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "postToDetailVC" {
            guard let index = tableView.indexPathForSelectedRow,
                let destVC = segue.destination as? PostDetailTableViewController else { return }
            let post = dataSource[index.row]
            destVC.post = post
        }
    }
}

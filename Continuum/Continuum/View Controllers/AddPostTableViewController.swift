//
//  AddPostTableViewController.swift
//  Continuum
//
//  Created by Apps on 8/27/19.
//  Copyright © 2019 Apps. All rights reserved.
//

import UIKit

class AddPostTableViewController: UITableViewController, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var textField: UITextField!
    
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureTapped))
        view.addGestureRecognizer(gesture)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        textField.text = ""
    }
    
    @objc func tapGestureTapped() {
        textField.resignFirstResponder()
    }
    
    @IBAction func addPostButtonTapped(_ sender: Any) {
        guard let image = image,
            let text = textField.text else { return }
        if !text.isEmpty {
            PostController.shared.createPostWith(image: image, caption: text) { (_) in
                
            }
            self.tabBarController?.selectedIndex = 0
        }
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.tabBarController?.selectedIndex = 0
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addPostToPhotoSelector" {
            guard let destVC = segue.destination as? PhotoSelectorViewController else { return }
            destVC.delegate = self
        }
    }
}

extension AddPostTableViewController: PhotoSelectorViewControllerDelegate {
    func photoSelectViewControllerSelectedImage(image: UIImage) {
        self.image = image
    }
}

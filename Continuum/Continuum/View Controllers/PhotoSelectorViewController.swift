//
//  PhotoSelectorViewController.swift
//  Continuum
//
//  Created by Apps on 8/28/19.
//  Copyright © 2019 Apps. All rights reserved.
//

import UIKit

class PhotoSelectorViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var selectAnImageButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    weak var delegate: PhotoSelectorViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func selectAnImageButtonTapped(_ sender: Any) {
        let alertController = UIAlertController(title: "Select Image", message: nil, preferredStyle: .actionSheet)
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        let cameraAlertAction = UIAlertAction(title: "Camera", style: .default, handler: { (_) in
            imagePicker.sourceType = .camera
            self.present(imagePicker, animated: true)
        })
        
        let photoLibraryAlertAction = UIAlertAction(title: "Library", style: .default, handler: { (_) in
            imagePicker.sourceType = .photoLibrary
            self.present(imagePicker, animated: true)
        })
        
        alertController.addAction(cameraAlertAction)
        alertController.addAction(photoLibraryAlertAction)
        
        present(alertController, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.delegate?.photoSelectViewControllerSelectedImage(image: pickedImage)
            imageView.contentMode = .scaleAspectFill
            imageView.image = pickedImage
        }
        selectAnImageButton.titleLabel?.text = ""
        dismiss(animated: true, completion: nil)
    }
}

protocol PhotoSelectorViewControllerDelegate: class {
    func photoSelectViewControllerSelectedImage(image: UIImage)
}

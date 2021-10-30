//
//  ViewController.swift
//  MemeMe
//
//  Created by skyme32 on 30/10/21.
//

import UIKit

class ViewController: UIViewController {

    // MARK: IBOutlet properties
    @IBOutlet weak var imagePicker: UIImageView!
    
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func pickAnImage(_ sender: Any) {
        showImagePickerController()
    }
    
}

// MARK: Control Picker controller
extension ViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    func showImagePickerController() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imagePicker.image = image
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

